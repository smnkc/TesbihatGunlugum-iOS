import SwiftUI

struct ProgressRingView: View {
    let progress: Double
    var lineWidth: CGFloat = 18
    @Environment(\.colorScheme) private var colorScheme
    private var isDarkMode: Bool { colorScheme == .dark }
    
    var body: some View {
        ZStack {
            // Arka Plan İz Halka
            Circle()
                .stroke(
                    isDarkMode ? Color.white.opacity(0.1) : Theme.primaryGreenColor.opacity(0.12),
                    lineWidth: lineWidth
                )
            
            // Mealim Sage-Mint Yeşil Gradiyentli Çubuk
            Circle()
                .trim(from: 0.0, to: CGFloat(min(progress, 1.0)))
                .stroke(
                    LinearGradient(
                        colors: [Theme.primaryGreenColor, Theme.secondaryGreenColor],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                )
                .rotationEffect(Angle(degrees: -90))
                .shadow(color: Theme.primaryGreenColor.opacity(0.25), radius: 8, x: 0, y: 4)
                .animation(.spring(response: 0.4, dampingFraction: 0.8), value: progress)
        }
    }
}
