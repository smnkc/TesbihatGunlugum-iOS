import SwiftUI

struct Theme {
    // MARK: - Mealim Renk Paleti
    static let primaryGreenColor = Color(red: 0.18, green: 0.36, blue: 0.27)   // SageGreen #2E5C45
    static let secondaryGreenColor = Color(red: 0.40, green: 0.62, blue: 0.50) // MintGreen #669E80
    static let offWhiteColor = Color.white                                     // Beyaz Zemin
    static let darkSlateColor = Color(red: 0.08, green: 0.12, blue: 0.10)      // DarkSlate #141F1A
    
    // MARK: - Net Beyaz Arka Plan Gradiyenti
    static func backgroundGradient(isDarkMode: Bool) -> LinearGradient {
        if isDarkMode {
            return LinearGradient(
                colors: [Color(red: 0.05, green: 0.08, blue: 0.07), Color(red: 0.08, green: 0.12, blue: 0.10)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        } else {
            return LinearGradient(
                colors: [Color.white, Color(red: 0.98, green: 0.99, blue: 0.98)],
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }
}

// MARK: - Türkçe Tarih Formatı Uzantısı
extension Date {
    var turkishFormattedDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "tr_TR")
        formatter.dateFormat = "d MMMM yyyy"
        return formatter.string(from: self)
    }
}

// MARK: - Mealim Özel Cam Kart (Glassmorphism) Modifier
struct GlassCardModifier: ViewModifier {
    var isDarkMode: Bool
    
    func body(content: Content) -> some View {
        let color1 = isDarkMode ? Color.white.opacity(0.15) : Color.black.opacity(0.08)
        let color2 = isDarkMode ? Color.white.opacity(0.02) : Color.black.opacity(0.03)
        
        return content
            .padding()
            .background(isDarkMode ? Color.white.opacity(0.05) : Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(
                        LinearGradient(
                            colors: [color1, color2],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
            }
            .shadow(
                color: isDarkMode ? Color.black.opacity(0.2) : Color.black.opacity(0.05),
                radius: 10,
                x: 0,
                y: 4
            )
    }
}

extension View {
    func glassCard(isDarkMode: Bool = false) -> some View {
        self.modifier(GlassCardModifier(isDarkMode: isDarkMode))
    }
}
