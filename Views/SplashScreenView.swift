import SwiftUI

struct SplashScreenView: View {
    @State private var scale: CGFloat = 0.85
    @State private var opacity: Double = 0.0
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 24) {
                // UYGULAMA İKONU LOGOSU (GÖLGESİZ & ARKA PLANSIZ TEMİZ HALE)
                Image("AppLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 130, height: 130)
                    .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
                    .scaleEffect(scale)
                    .opacity(opacity)
                
                VStack(spacing: 6) {
                    Text("Tesbihat Günlüğüm")
                        .font(.system(size: 26, weight: .bold, design: .serif))
                        .foregroundStyle(Theme.darkSlateColor)
                    
                    Text("Zikir & Tesbihat Rehberiniz")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .opacity(opacity)
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.8)) {
                scale = 1.0
                opacity = 1.0
            }
        }
    }
}
