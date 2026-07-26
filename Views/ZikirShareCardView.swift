import SwiftUI

struct ZikirShareCardView: View {
    let title: String
    let turkishPronunciation: String?
    let arabicText: String?
    let currentCount: Int
    let targetCount: Int
    let isCompleted: Bool
    let note: String?
    
    init(event: EtkinlikModel) {
        self.title = event.activeTitle
        self.turkishPronunciation = event.activePronunciation
        self.arabicText = event.activeArabicText
        self.currentCount = event.currentCount
        self.targetCount = event.targetCount
        self.isCompleted = event.isCompleted
        self.note = event.note
    }
    
    init(
        title: String,
        turkishPronunciation: String? = nil,
        arabicText: String? = nil,
        currentCount: Int,
        targetCount: Int,
        isCompleted: Bool = false,
        note: String? = nil
    ) {
        self.title = title
        self.turkishPronunciation = turkishPronunciation
        self.arabicText = arabicText
        self.currentCount = currentCount
        self.targetCount = targetCount
        self.isCompleted = isCompleted
        self.note = note
    }
    
    private var progressPercentage: Double {
        guard targetCount > 0 else { return 0.0 }
        return min(Double(currentCount) / Double(targetCount), 1.0)
    }
    
    var body: some View {
        ZStack {
            // Arka Plan Lüks Gradiyent
            LinearGradient(
                colors: [
                    Color(red: 0.12, green: 0.26, blue: 0.20),
                    Color(red: 0.18, green: 0.36, blue: 0.27),
                    Color(red: 0.08, green: 0.16, blue: 0.12)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            // Cam İçi Çerçeve Koyu Desen
            VStack(spacing: 20) {
                // ÜST BAŞLIK VE AMBLEM
                HStack(spacing: 8) {
                    Image(systemName: "sparkles")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(Color(red: 0.92, green: 0.78, blue: 0.45)) // Altın Sarısı
                    
                    Text("Tesbihat Günlüğüm")
                        .font(.system(size: 18, weight: .bold, design: .serif))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    if isCompleted {
                        Text("TAMAMLANDI 🎉")
                            .font(.system(size: 10, weight: .bold))
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color(red: 0.92, green: 0.78, blue: 0.45))
                            .foregroundColor(.black)
                            .clipShape(Capsule())
                    }
                }
                .padding(.bottom, 6)
                
                Divider()
                    .overlay(Color.white.opacity(0.2))
                
                // ORTA İÇERİK: ZİKİR BİLGİLERİ
                VStack(spacing: 12) {
                    Text(title)
                        .font(.system(size: 22, weight: .bold, design: .serif))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                    
                    if let arabic = arabicText, !arabic.isEmpty {
                        Text(arabic)
                            .font(.system(size: 26, weight: .semibold))
                            .foregroundColor(Color(red: 0.60, green: 0.88, blue: 0.72))
                            .multilineTextAlignment(.center)
                            .lineLimit(3)
                            .padding(.vertical, 2)
                    }
                    
                    if let pron = turkishPronunciation, !pron.isEmpty {
                        Text("“\(pron)”")
                            .font(.system(size: 15, weight: .semibold, design: .serif))
                            .foregroundColor(Color.white.opacity(0.9))
                            .multilineTextAlignment(.center)
                            .lineLimit(4)
                            .lineSpacing(4)
                    }
                    
                    if let note = note, !note.isEmpty {
                        Text("Niyet: \(note)")
                            .font(.system(size: 12, weight: .medium, design: .serif))
                            .italic()
                            .foregroundColor(Color.white.opacity(0.7))
                            .padding(.top, 4)
                    }
                }
                .padding(.vertical, 8)
                
                Spacer(minLength: 0)
                
                // ALT BİLGİ VE İLERLEME SAYACI
                VStack(spacing: 8) {
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("OKUNAN MİKTAR")
                                .font(.system(size: 10, weight: .bold, design: .monospaced))
                                .foregroundColor(Color.white.opacity(0.6))
                            
                            Text("\(currentCount.formatted()) / \(targetCount.formatted()) Tekrar")
                                .font(.system(size: 16, weight: .bold, design: .serif))
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                        
                        Text("%\(Int(progressPercentage * 100))")
                            .font(.system(size: 28, weight: .bold, design: .serif))
                            .foregroundColor(Color(red: 0.92, green: 0.78, blue: 0.45))
                    }
                    
                    // İlerleme Çubuğu
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(Color.white.opacity(0.15))
                            .frame(height: 8)
                        
                        Capsule()
                            .fill(
                                LinearGradient(
                                    colors: [Color(red: 0.92, green: 0.78, blue: 0.45), Color(red: 0.60, green: 0.88, blue: 0.72)],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(width: max(10, 320 * CGFloat(progressPercentage)), height: 8)
                    }
                }
                .padding(14)
                .background(Color.white.opacity(0.08))
                .cornerRadius(16)
                
                // ALT BRANDING FOOTER
                HStack {
                    Image(systemName: "hand.tap.fill")
                        .font(.system(size: 11))
                        .foregroundColor(Color.white.opacity(0.5))
                    Text("Tesbihat Günlüğüm ile zikredildi")
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(Color.white.opacity(0.5))
                }
                .padding(.top, 4)
            }
            .padding(24)
            .overlay(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .stroke(
                        LinearGradient(
                            colors: [Color.white.opacity(0.3), Color.white.opacity(0.05)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1.5
                    )
            )
        }
        .frame(width: 360, height: 480)
        .cornerRadius(24)
    }
}
