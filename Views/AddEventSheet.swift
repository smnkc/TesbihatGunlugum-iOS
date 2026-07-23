import SwiftUI
import SwiftData

struct AddEventSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) private var colorScheme
    private var isDarkMode: Bool { colorScheme == .dark }
    
    var initialTemplate: ZikirTemplate? = nil
    
    @State private var title: String
    @State private var turkishPronunciation: String
    @State private var targetCountString: String
    @State private var note: String
    
    init(initialTemplate: ZikirTemplate? = nil) {
        self.initialTemplate = initialTemplate
        _title = State(initialValue: initialTemplate?.title ?? "")
        _turkishPronunciation = State(initialValue: initialTemplate?.turkishPronunciation ?? "")
        _targetCountString = State(initialValue: "\(initialTemplate?.defaultTarget ?? 1000)")
        _note = State(initialValue: initialTemplate?.meaning ?? "")
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Theme.backgroundGradient(isDarkMode: isDarkMode).ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        
                        // ETKİNLİK DETAYLARI KARTI
                        VStack(alignment: .leading, spacing: 12) {
                            Text("ETKİNLİK BİLGİLERİ")
                                .font(.system(size: 11, weight: .bold, design: .monospaced))
                                .foregroundStyle(Theme.primaryGreenColor)
                                .tracking(1)
                                .padding(.horizontal, 4)
                            
                            VStack(spacing: 12) {
                                // 1. Etkinlik Adı (Şablonda Sabit Kilitli)
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Etkinlik / Zikir Adı")
                                        .font(.caption)
                                        .bold()
                                        .foregroundStyle(.secondary)
                                    
                                    if initialTemplate != nil {
                                        HStack {
                                            Text(title)
                                                .font(.system(.body, design: .serif).weight(.bold))
                                                .foregroundStyle(isDarkMode ? .white : Theme.darkSlateColor)
                                                .lineLimit(1)
                                                .minimumScaleFactor(0.85)
                                            Spacer()
                                            Image(systemName: "lock.fill")
                                                .font(.caption)
                                                .foregroundColor(.gray)
                                        }
                                        .padding(10)
                                        .background(isDarkMode ? Color.white.opacity(0.05) : Color(red: 0.95, green: 0.96, blue: 0.97))
                                        .cornerRadius(12)
                                    } else {
                                        TextField("Örn: 40 Bin Kelime-i Tevhid", text: $title)
                                            .font(.system(.body, design: .serif))
                                            .padding(10)
                                            .background(isDarkMode ? Color.white.opacity(0.08) : Color(red: 0.96, green: 0.97, blue: 0.98))
                                            .cornerRadius(12)
                                    }
                                }
                                
                                // 2. Türkçe Okunuş (Denge Sağlayan İç Kaydırmalı Kutu)
                                if initialTemplate != nil {
                                    if !turkishPronunciation.isEmpty {
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text("Türkçe Okunuşu")
                                                .font(.caption)
                                                .bold()
                                                .foregroundStyle(.secondary)
                                            
                                            ScrollView(.vertical, showsIndicators: true) {
                                                Text("“\(turkishPronunciation)”")
                                                    .font(.system(size: 13, design: .serif).weight(.semibold))
                                                    .foregroundStyle(Theme.primaryGreenColor)
                                                    .multilineTextAlignment(.leading)
                                                    .padding(8)
                                            }
                                            .frame(maxHeight: 105)
                                            .background(Theme.primaryGreenColor.opacity(0.08))
                                            .cornerRadius(12)
                                        }
                                    }
                                } else {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("Türkçe Okunuşu (Opsiyonel)")
                                            .font(.caption)
                                            .bold()
                                            .foregroundStyle(.secondary)
                                        TextField("Örn: Lâ ilâhe illallâh", text: $turkishPronunciation)
                                            .font(.system(.body, design: .serif))
                                            .padding(10)
                                            .background(isDarkMode ? Color.white.opacity(0.08) : Color(red: 0.96, green: 0.97, blue: 0.98))
                                            .cornerRadius(12)
                                    }
                                }
                                
                                // 3. Hedef Sayı (Her Zaman Düzenlenebilir)
                                VStack(alignment: .leading, spacing: 4) {
                                    HStack {
                                        Text("Hedef Sayı")
                                            .font(.caption)
                                            .bold()
                                            .foregroundStyle(.secondary)
                                        Spacer()
                                        Text("(Maksimum: 1.000.000)")
                                            .font(.caption2)
                                            .foregroundStyle(.secondary)
                                    }
                                    TextField("Hedef", text: $targetCountString)
                                        .font(.system(.body, design: .monospaced))
                                        .keyboardType(.numberPad)
                                        .padding(10)
                                        .background(isDarkMode ? Color.white.opacity(0.08) : Color(red: 0.96, green: 0.97, blue: 0.98))
                                        .cornerRadius(12)
                                }
                            }
                            .glassCard(isDarkMode: isDarkMode)
                        }
                        
                        // NİYET / NOT KUTUSU
                        VStack(alignment: .leading, spacing: 8) {
                            Text("NİYET / NOT (OPSİYONEL)")
                                .font(.system(size: 11, weight: .bold, design: .monospaced))
                                .foregroundStyle(Theme.primaryGreenColor)
                                .tracking(1)
                                .padding(.horizontal, 4)
                            
                            TextField("Niyetiniz veya özel notunuz...", text: $note, axis: .vertical)
                                .font(.system(.body, design: .serif))
                                .lineLimit(2...3)
                                .padding(10)
                                .background(isDarkMode ? Color.white.opacity(0.08) : Color.white)
                                .cornerRadius(16)
                                .shadow(color: Color.black.opacity(0.03), radius: 6, x: 0, y: 3)
                        }
                        
                        // BÜYÜK KAYDET BUTONU (RAHAT TIKLANABİLİR VE ASLA ALTTA KALMAZ)
                        Button {
                            saveEvent()
                        } label: {
                            Text("Etkinliği Oluştur")
                                .font(.headline)
                                .bold()
                                .frame(maxWidth: .infinity, minHeight: 48)
                                .background(
                                    title.trimmingCharacters(in: .whitespaces).isEmpty ?
                                    LinearGradient(colors: [Color.gray.opacity(0.3)], startPoint: .leading, endPoint: .trailing) :
                                    LinearGradient(colors: [Theme.primaryGreenColor, Theme.secondaryGreenColor], startPoint: .leading, endPoint: .trailing)
                                )
                                .foregroundColor(.white)
                                .cornerRadius(18)
                                .shadow(color: Theme.primaryGreenColor.opacity(0.3), radius: 8, x: 0, y: 4)
                        }
                        .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
                        .padding(.top, 4)
                        .padding(.bottom, 28) // ALT BOŞLUK GARANTİSİ
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                }
            }
            .navigationTitle(initialTemplate != nil ? "Şablonla Başla" : "Yeni Etkinlik")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("İptal") { dismiss() }
                        .foregroundStyle(Theme.primaryGreenColor)
                }
            }
        }
    }
    
    private func saveEvent() {
        let rawTarget = Int(targetCountString) ?? 1000
        let target = min(max(rawTarget, 1), 1_000_000)
        let isSetTemplate = initialTemplate?.steps != nil
        
        let newEvent = EtkinlikModel(
            title: title.trimmingCharacters(in: .whitespaces),
            targetCount: target,
            note: note.isEmpty ? nil : note,
            turkishPronunciation: turkishPronunciation.isEmpty ? nil : turkishPronunciation,
            isSet: isSetTemplate,
            steps: initialTemplate?.steps
        )
        modelContext.insert(newEvent)
        try? modelContext.save()
        dismiss()
    }
}
