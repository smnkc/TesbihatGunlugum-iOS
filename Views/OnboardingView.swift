import SwiftUI

struct OnboardingView: View {
    @Binding var isPresented: Bool
    @Environment(\.colorScheme) private var colorScheme
    private var isDarkMode: Bool { colorScheme == .dark }
    
    var body: some View {
        ZStack {
            Theme.backgroundGradient(isDarkMode: isDarkMode).ignoresSafeArea()
            
            VStack(spacing: 20) {
                // ÜST BAŞLIK
                VStack(spacing: 6) {
                    Image(systemName: "sparkles")
                        .font(.system(size: 38))
                        .foregroundStyle(Theme.primaryGreenColor)
                    
                    Text("Tesbihat Günlüğüm")
                        .font(.system(.title2, design: .serif).weight(.bold))
                        .foregroundStyle(isDarkMode ? .white : Theme.darkSlateColor)
                    
                    Text("Zikir ve Tesbihat Rehberiniz")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.top, 24)
                
                // TEK SAYFADA TÜM ÖZELLİKLER LİSTESİ
                VStack(alignment: .leading, spacing: 16) {
                    OnboardingFeatureRow(
                        icon: "number.circle.fill",
                        title: "Sayaç & Zikirmatik",
                        description: "Ekrana dokunarak zikredin. 'Kilitle' butonu ile ekranı kilitleyin, 'Geri Al (-1)' ile hatalı dokunmayı düzeltin."
                    )
                    
                    OnboardingFeatureRow(
                        icon: "book.fill",
                        title: "Hazır Tesbihat Setleri",
                        description: "33'erli Namaz Tesbihatı, 99 Esma-ül Hüsna ve 38 Adımlı Uzun Tesbihat setlerini tek tıkla doğrudan başlatın."
                    )
                    
                    OnboardingFeatureRow(
                        icon: "calendar.day.timeline.left",
                        title: "Günlük Takip & Arşiv",
                        description: "Devam eden zikirlerinizi gün gün takip edin. Tamamlanan zikirler geçmiş arşivinde saklanır."
                    )
                    
                    OnboardingFeatureRow(
                        icon: "bell.badge.fill",
                        title: "%100 Çevrimdışı Hatırlatıcı",
                        description: "İnternetiniz olmasa dahi belirlediğiniz saatte cihazınız zikir saatinizi hatırlatır."
                    )
                }
                .glassCard(isDarkMode: isDarkMode)
                .padding(.horizontal, 20)
                
                Spacer()
                
                // ANLADIM VE BAŞLA BUTONU
                Button {
                    withAnimation {
                        isPresented = false
                    }
                } label: {
                    Text("Anladım, Başla")
                        .font(.headline)
                        .bold()
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(
                            LinearGradient(
                                colors: [Theme.primaryGreenColor, Theme.secondaryGreenColor],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .foregroundColor(.white)
                        .cornerRadius(18)
                        .shadow(color: Theme.primaryGreenColor.opacity(0.3), radius: 8, x: 0, y: 4)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
            }
        }
    }
}

struct OnboardingFeatureRow: View {
    let icon: String
    let title: String
    let description: String
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: 26))
                .foregroundStyle(Theme.primaryGreenColor)
                .frame(width: 32, height: 32)
            
            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.system(size: 15, weight: .bold, design: .serif))
                    .foregroundStyle(colorScheme == .dark ? .white : Theme.darkSlateColor)
                
                Text(description)
                    .font(.system(size: 12.5))
                    .foregroundColor(.gray)
                    .lineSpacing(2)
            }
        }
    }
}
