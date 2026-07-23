import SwiftUI
import SwiftData

struct DailyEventsView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) private var colorScheme
    private var isDarkMode: Bool { colorScheme == .dark }
    
    @Query(filter: #Predicate<EtkinlikModel> { $0.isCompleted == false }, sort: \EtkinlikModel.startDate, order: .reverse)
    private var activeEvents: [EtkinlikModel]
    
    @Binding var selectedEvent: EtkinlikModel?
    @Binding var selectedTab: Int
    @Binding var showAddSheet: Bool
    
    @State private var eventToDelete: EtkinlikModel? = nil
    
    var body: some View {
        NavigationStack {
            ZStack {
                Theme.backgroundGradient(isDarkMode: isDarkMode).ignoresSafeArea()
                
                if activeEvents.isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "calendar.badge.plus")
                            .font(.system(size: 60))
                            .foregroundStyle(Theme.primaryGreenColor)
                        
                        Text("Henüz Günlük Zikir Yok")
                            .font(.system(.title3, design: .serif).weight(.bold))
                            .foregroundStyle(isDarkMode ? .white : Theme.darkSlateColor)
                        
                        Text("Günlük takibini yapmak istediğiniz yeni bir zikir ekleyin.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                        
                        Button {
                            showAddSheet = true
                        } label: {
                            HStack {
                                Image(systemName: "plus")
                                Text("Zikir Ekle")
                            }
                            .font(.headline)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 12)
                            .background(Theme.primaryGreenColor)
                            .foregroundColor(.white)
                            .cornerRadius(16)
                        }
                    }
                } else {
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(activeEvents) { event in
                                HStack(alignment: .center, spacing: 12) {
                                    VStack(alignment: .leading, spacing: 6) {
                                        HStack {
                                            Text(event.title)
                                                .font(.system(size: 15, weight: .bold, design: .serif))
                                                .foregroundStyle(isDarkMode ? .white : Theme.darkSlateColor)
                                                .lineLimit(1)
                                                .minimumScaleFactor(0.8)
                                            
                                            Spacer()
                                            
                                            // Sil Butonu
                                            Button {
                                                eventToDelete = event
                                            } label: {
                                                Image(systemName: "trash")
                                                    .font(.caption2)
                                                    .foregroundStyle(Color.red.opacity(0.8))
                                                    .padding(6)
                                                    .background(Color.red.opacity(0.1))
                                                    .clipShape(Circle())
                                            }
                                            .buttonStyle(.plain)
                                        }
                                        
                                        if let note = event.note, !note.isEmpty {
                                            Text("“\(note)”")
                                                .font(.system(size: 12, design: .serif).weight(.semibold))
                                                .foregroundStyle(Theme.primaryGreenColor)
                                                .lineLimit(1)
                                        }
                                        
                                        // İlerleme Çubuğu
                                        GeometryReader { geo in
                                            ZStack(alignment: .leading) {
                                                RoundedRectangle(cornerRadius: 6)
                                                    .fill(Color.gray.opacity(0.15))
                                                    .frame(height: 6)
                                                
                                                RoundedRectangle(cornerRadius: 6)
                                                    .fill(
                                                        LinearGradient(
                                                            colors: [Theme.primaryGreenColor, Theme.secondaryGreenColor],
                                                            startPoint: .leading,
                                                            endPoint: .trailing
                                                        )
                                                    )
                                                    .frame(width: max(0, min(geo.size.width, geo.size.width * CGFloat(event.progressPercentage))), height: 6)
                                            }
                                        }
                                        .frame(height: 6)
                                        
                                        HStack {
                                            Text("Okunan: \(event.currentCount.formatted()) / \(event.targetCount.formatted())")
                                                .font(.system(size: 11))
                                                .foregroundColor(.gray)
                                            
                                            Spacer()
                                            
                                            // Sayaç Sayfasına Git ve Seç
                                            Button {
                                                selectedEvent = event
                                                selectedTab = 0 // Sayaç sekmesine geç
                                            } label: {
                                                HStack(spacing: 4) {
                                                    Image(systemName: "play.fill")
                                                        .font(.caption2)
                                                    Text("Zikret")
                                                        .font(.caption)
                                                        .bold()
                                                }
                                                .padding(.horizontal, 14)
                                                .padding(.vertical, 7)
                                                .background(Theme.primaryGreenColor)
                                                .foregroundColor(.white)
                                                .cornerRadius(12)
                                                .shadow(color: Theme.primaryGreenColor.opacity(0.3), radius: 4, x: 0, y: 2)
                                            }
                                            .buttonStyle(.plain)
                                        }
                                    }
                                }
                                .frame(height: 122) // STANDART 122pt YÜKSEKLİK
                                .glassCard(isDarkMode: isDarkMode)
                                .padding(.horizontal, 16)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
            .navigationTitle("Günlük Zikirlerim")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showAddSheet = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .foregroundStyle(Theme.primaryGreenColor)
                    }
                }
            }
            // TEMİZ VE SABİT EKRAN ORTASI UYARISI
            .alert(item: $eventToDelete) { event in
                Alert(
                    title: Text("Etkinliği Sil"),
                    message: Text("\"\(event.title)\" zikri silinecektir. Bu işlem geri alınamaz."),
                    primaryButton: .destructive(Text("Sil")) {
                        deleteEvent(event)
                    },
                    secondaryButton: .cancel(Text("İptal"))
                )
            }
        }
    }
    
    private func deleteEvent(_ event: EtkinlikModel) {
        if selectedEvent?.id == event.id {
            selectedEvent = nil
        }
        modelContext.delete(event)
        try? modelContext.save()
    }
}
