import SwiftUI
import SwiftData

struct HistoryView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) private var colorScheme
    private var isDarkMode: Bool { colorScheme == .dark }
    
    @Query(filter: #Predicate<EtkinlikModel> { $0.isCompleted == true }, sort: \EtkinlikModel.completedDate, order: .reverse)
    private var completedEvents: [EtkinlikModel]
    
    @Binding var selectedEvent: EtkinlikModel?
    @Binding var selectedTab: Int
    
    @State private var eventToDelete: EtkinlikModel? = nil
    
    var body: some View {
        NavigationStack {
            ZStack {
                Theme.backgroundGradient(isDarkMode: isDarkMode).ignoresSafeArea()
                
                if completedEvents.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "archivebox.fill")
                            .font(.system(size: 60))
                            .foregroundStyle(Theme.primaryGreenColor.opacity(0.4))
                        
                        Text("Henüz Geçmiş Etkinlik Yok")
                            .font(.system(.title3, design: .serif).weight(.bold))
                            .foregroundStyle(isDarkMode ? .white : Theme.darkSlateColor)
                        
                        Text("Tamamladığınız zikir ve tesbihatlar burada düzenli bir şekilde arşivlenecektir.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                    }
                } else {
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(completedEvents) { event in
                                HStack(alignment: .center, spacing: 12) {
                                    VStack(alignment: .leading, spacing: 6) {
                                        HStack {
                                            Text(event.title)
                                                .font(.system(size: 15, weight: .bold, design: .serif))
                                                .foregroundStyle(isDarkMode ? .white : Theme.darkSlateColor)
                                                .lineLimit(1)
                                                .minimumScaleFactor(0.8)
                                            
                                            Spacer()
                                            
                                            Label("Tamamlandı", systemImage: "checkmark.seal.fill")
                                                .font(.caption2)
                                                .bold()
                                                .foregroundStyle(Theme.primaryGreenColor)
                                        }
                                        
                                        HStack(spacing: 12) {
                                            HStack(spacing: 4) {
                                                Image(systemName: "calendar")
                                                    .font(.caption2)
                                                    .foregroundStyle(Theme.primaryGreenColor)
                                                Text(event.startDate.turkishFormattedDate)
                                                    .font(.caption2)
                                                    .foregroundStyle(.secondary)
                                            }
                                            
                                            HStack(spacing: 4) {
                                                Image(systemName: "hourglass")
                                                    .font(.caption2)
                                                    .foregroundStyle(Theme.primaryGreenColor)
                                                Text(event.completionDaysText)
                                                    .font(.caption2)
                                                    .bold()
                                                    .foregroundStyle(isDarkMode ? .white : Theme.darkSlateColor)
                                            }
                                            
                                            HStack(spacing: 4) {
                                                Image(systemName: "number.circle.fill")
                                                    .font(.caption2)
                                                    .foregroundStyle(Theme.primaryGreenColor)
                                                Text("\(event.targetCount.formatted()) Tekrar")
                                                    .font(.caption2)
                                                    .bold()
                                                    .foregroundStyle(isDarkMode ? .white : Theme.darkSlateColor)
                                            }
                                        }
                                        
                                        if let note = event.note, !note.isEmpty {
                                            Text("“\(note)”")
                                                .font(.system(size: 11.5, design: .serif).weight(.semibold))
                                                .foregroundStyle(Theme.primaryGreenColor)
                                                .lineLimit(1)
                                        } else {
                                            Text("Başarıyla tamamlanan tesbihat kaydı.")
                                                .font(.system(size: 11))
                                                .foregroundColor(.gray)
                                                .lineLimit(1)
                                        }
                                        
                                        HStack {
                                            Spacer()
                                            
                                            // Paylaş Butonu
                                            let cardView = ZikirShareCardView(event: event)
                                            let renderer = ImageRenderer(content: cardView)
                                            if let image = renderer.uiImage {
                                                ShareLink(item: Image(uiImage: image), preview: SharePreview(event.title, image: Image(uiImage: image))) {
                                                    Image(systemName: "square.and.arrow.up")
                                                        .font(.caption2)
                                                        .foregroundStyle(Theme.primaryGreenColor)
                                                        .padding(6)
                                                        .background(Theme.primaryGreenColor.opacity(0.12))
                                                        .clipShape(Circle())
                                                }
                                                .buttonStyle(.plain)
                                            }
                                            
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
                                            
                                            // Tekrarla Butonu
                                            Button {
                                                repeatEvent(event)
                                            } label: {
                                                HStack(spacing: 4) {
                                                    Image(systemName: "arrow.clockwise")
                                                        .font(.caption2)
                                                    Text("Tekrarla")
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
            .navigationTitle("Geçmiş / Arşiv")
            // TEMİZ VE SABİT EKRAN ORTASI UYARISI
            .alert(item: $eventToDelete) { event in
                Alert(
                    title: Text("Arşiv Kaydını Sil"),
                    message: Text("\"\(event.title)\" geçmiş zikir kaydı silinecektir."),
                    primaryButton: .destructive(Text("Sil")) {
                        deleteEvent(event)
                    },
                    secondaryButton: .cancel(Text("İptal"))
                )
            }
        }
    }
    
    private func repeatEvent(_ event: EtkinlikModel) {
        let newEvent = EtkinlikModel(
            title: event.title,
            targetCount: event.targetCount,
            currentCount: 0,
            note: event.note,
            turkishPronunciation: event.turkishPronunciation,
            arabicText: event.arabicText,
            isSet: event.isSet,
            steps: event.steps
        )
        modelContext.insert(newEvent)
        try? modelContext.save()
        
        selectedEvent = newEvent
        selectedTab = 0 // Sayaç ekranına yönlendir
    }
    
    private func deleteEvent(_ event: EtkinlikModel) {
        modelContext.delete(event)
        try? modelContext.save()
    }
}
