import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) private var colorScheme
    private var isDarkMode: Bool { colorScheme == .dark }
    
    @Query(filter: #Predicate<EtkinlikModel> { $0.isCompleted == false }, sort: \EtkinlikModel.startDate, order: .reverse)
    private var activeEvents: [EtkinlikModel]
    
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding: Bool = false
    @AppStorage("lastSelectedEventId") private var lastSelectedEventId: String = ""
    
    @State private var selectedEvent: EtkinlikModel? = nil
    @State private var showAddEventSheet: Bool = false
    @State private var selectedTemplateForSheet: ZikirTemplate? = nil
    @State private var selectedTab: Int = 0
    @State private var showOnboardingSheet: Bool = false
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // 1. SAYAÇ (SEÇİLİ VEYA İLK ZİKİR)
            NavigationStack {
                ZStack {
                    Theme.backgroundGradient(isDarkMode: isDarkMode).ignoresSafeArea()
                    
                    if let currentEvent = selectedEvent ?? activeEvents.first {
                        CounterView(event: currentEvent)
                    } else {
                        NoEventSelectedView(showAddSheet: $showAddEventSheet)
                    }
                }
            }
            .tabItem {
                Label("Sayaç", systemImage: "number.circle.fill")
            }
            .tag(0)
            
            // 2. GÜNLÜK ZİKİRLER LİSTESİ
            DailyEventsView(
                selectedEvent: $selectedEvent,
                selectedTab: $selectedTab,
                showAddSheet: $showAddEventSheet
            )
            .tabItem {
                Label("Günlük", systemImage: "calendar.day.timeline.left")
            }
            .tag(1)
            
            // 3. İSTATİSTİK / GEÇMİŞ
            HistoryView(
                selectedEvent: $selectedEvent,
                selectedTab: $selectedTab
            )
            .tabItem {
                Label("İstatistik", systemImage: "chart.bar.fill")
            }
            .tag(2)
            
            // 4. TESBİHATLAR (ŞABLONLAR)
            TemplatesView(
                selectedTemplateForSheet: $selectedTemplateForSheet,
                selectedEvent: $selectedEvent,
                selectedTab: $selectedTab
            )
            .tabItem {
                Label("Tesbihatlar", systemImage: "book.fill")
            }
            .tag(3)
            
            // 5. AYARLAR
            SettingsView()
                .tabItem {
                    Label("Ayarlar", systemImage: "gearshape.fill")
                }
                .tag(4)
        }
        .accentColor(Theme.primaryGreenColor)
        // BOŞ YENİ ETKİNLİK PENCERESİ
        .sheet(isPresented: $showAddEventSheet) {
            AddEventSheet(initialTemplate: nil)
                .presentationDetents([.fraction(0.92), .large])
                .presentationDragIndicator(.visible)
        }
        // ŞABLON İLE DOLDURULMUŞ ETKİNLİK PENCERESİ (Sadece Tekli Zikirler İçin)
        .sheet(item: $selectedTemplateForSheet) { template in
            AddEventSheet(initialTemplate: template)
                .presentationDetents([.fraction(0.94), .large])
                .presentationDragIndicator(.visible)
        }
        // İLK YÜKLENME BİR DEFALIK TANITIM EKRANI
        .sheet(isPresented: $showOnboardingSheet, onDismiss: {
            hasCompletedOnboarding = true
        }) {
            OnboardingView(isPresented: $showOnboardingSheet)
                .interactiveDismissDisabled(true)
        }
        .onChange(of: selectedEvent) { _, newEvent in
            if let newEvent = newEvent {
                lastSelectedEventId = newEvent.id.uuidString
            }
        }
        .onAppear {
            if !hasCompletedOnboarding {
                showOnboardingSheet = true
            }
            restoreLastSelectedEvent()
        }
    }
    
    private func restoreLastSelectedEvent() {
        if !lastSelectedEventId.isEmpty, let uuid = UUID(uuidString: lastSelectedEventId) {
            if let found = activeEvents.first(where: { $0.id == uuid }) {
                selectedEvent = found
            }
        }
    }
}

struct NoEventSelectedView: View {
    @Binding var showAddSheet: Bool
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "hand.tap.fill")
                .font(.system(size: 70))
                .foregroundStyle(Theme.primaryGreenColor)
            
            Text("Aktif Zikir Bulunmuyor")
                .font(.system(.title2, design: .serif).weight(.bold))
                .foregroundStyle(colorScheme == .dark ? .white : Theme.darkSlateColor)
            
            Text("Yeni bir zikir etkinliği ekleyerek veya Tesbihatlar sekmesinden bir zikir seçerek hemen başlayabilirsiniz.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Button {
                showAddSheet = true
            } label: {
                HStack {
                    Image(systemName: "plus")
                    Text("Yeni Etkinlik Ekle")
                }
                .font(.headline)
                .padding()
                .frame(width: 220)
                .background(
                    LinearGradient(
                        colors: [Theme.primaryGreenColor, Theme.secondaryGreenColor],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .foregroundColor(.white)
                .cornerRadius(20)
                .shadow(color: Theme.primaryGreenColor.opacity(0.3), radius: 8, x: 0, y: 4)
            }
        }
    }
}

struct TemplatesView: View {
    @Binding var selectedTemplateForSheet: ZikirTemplate?
    @Binding var selectedEvent: EtkinlikModel?
    @Binding var selectedTab: Int
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) private var colorScheme
    private var isDarkMode: Bool { colorScheme == .dark }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Theme.backgroundGradient(isDarkMode: isDarkMode).ignoresSafeArea()
                
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 14) {
                        ForEach(ZikirCategory.allCases) { category in
                            let categoryTemplates = ZikirTemplate.presetTemplates.filter { $0.category == category }
                            
                            if !categoryTemplates.isEmpty {
                                VStack(alignment: .leading, spacing: 8) {
                                    // KATEGORİ BAŞLIĞI
                                    Text(category.rawValue.uppercased())
                                        .font(.system(size: 11, weight: .bold, design: .monospaced))
                                        .foregroundStyle(Theme.primaryGreenColor)
                                        .tracking(1)
                                        .padding(.horizontal, 20)
                                        .padding(.top, 10)
                                    
                                    ForEach(categoryTemplates) { template in
                                        HStack(alignment: .center, spacing: 12) {
                                            VStack(alignment: .leading, spacing: 4) {
                                                HStack(spacing: 6) {
                                                    if template.steps != nil {
                                                        Text("SET")
                                                            .font(.system(size: 10, weight: .bold))
                                                            .padding(.horizontal, 6)
                                                            .padding(.vertical, 2)
                                                            .background(Theme.primaryGreenColor)
                                                            .foregroundColor(.white)
                                                            .cornerRadius(6)
                                                    }
                                                    Text(template.title)
                                                        .font(.system(size: 15, weight: .bold, design: .serif))
                                                        .foregroundStyle(isDarkMode ? .white : Theme.darkSlateColor)
                                                        .lineLimit(1)
                                                        .minimumScaleFactor(0.75)
                                                }
                                                
                                                if let pron = template.turkishPronunciation {
                                                    Text("“\(pron)”")
                                                        .font(.system(size: 12.5, design: .serif).weight(.semibold))
                                                        .foregroundStyle(Theme.primaryGreenColor)
                                                        .lineLimit(2)
                                                        .minimumScaleFactor(0.8)
                                                }
                                                
                                                if let arabic = template.arabicText {
                                                    Text(arabic)
                                                        .font(.system(size: 12.5))
                                                        .foregroundStyle(Theme.secondaryGreenColor)
                                                        .lineLimit(1)
                                                        .minimumScaleFactor(0.8)
                                                }
                                                
                                                Text("Varsayılan Hedef: \(template.defaultTarget.formatted())")
                                                    .font(.system(size: 11))
                                                    .foregroundColor(.gray)
                                            }
                                            
                                            Spacer(minLength: 4)
                                            
                                            // SET İSE DOĞRUDAN SAYAÇ EKRANINA GEÇER, TEKLİ İSE DÜZENLEME AÇAR
                                            Button {
                                                if template.steps != nil {
                                                    startSetDirectly(template)
                                                } else {
                                                    selectedTemplateForSheet = template
                                                }
                                            } label: {
                                                HStack(spacing: 4) {
                                                    Image(systemName: "play.fill")
                                                        .font(.caption2)
                                                    Text("Başlat")
                                                        .font(.caption)
                                                        .bold()
                                                }
                                                .padding(.horizontal, 14)
                                                .padding(.vertical, 10)
                                                .background(Theme.primaryGreenColor)
                                                .foregroundColor(.white)
                                                .cornerRadius(12)
                                                .shadow(color: Theme.primaryGreenColor.opacity(0.3), radius: 4, x: 0, y: 2)
                                            }
                                            .buttonStyle(.plain)
                                        }
                                        .frame(height: 122) // STANDART VE EŞİT YÜKSEKLİKLİ KARTLAR
                                        .glassCard(isDarkMode: isDarkMode)
                                        .padding(.horizontal, 16)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.bottom, 24)
                }
            }
            .navigationTitle("Tesbihatlar")
        }
    }
    
    // HAZIR SETİ DÜZENLEME OLMADAN ANINDA BAŞLATMA
    private func startSetDirectly(_ template: ZikirTemplate) {
        let newEvent = EtkinlikModel(
            title: template.title,
            targetCount: template.defaultTarget,
            note: template.meaning,
            turkishPronunciation: template.turkishPronunciation,
            isSet: true,
            steps: template.steps
        )
        modelContext.insert(newEvent)
        try? modelContext.save()
        
        selectedEvent = newEvent
        selectedTab = 0 // Doğrudan Sayaç sekmesine geçiş
    }
}
