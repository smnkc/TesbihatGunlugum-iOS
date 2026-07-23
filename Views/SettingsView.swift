import SwiftUI

struct SettingsView: View {
    @AppStorage("isSoundEnabled") private var isSoundEnabled: Bool = true
    @AppStorage("isHapticEnabled") private var isHapticEnabled: Bool = true
    @AppStorage("reminderHour") private var reminderHour: Int = 21
    @AppStorage("reminderMinute") private var reminderMinute: Int = 0
    @AppStorage("isReminderEnabled") private var isReminderEnabled: Bool = false
    
    @Environment(\.colorScheme) private var colorScheme
    private var isDarkMode: Bool { colorScheme == .dark }
    
    @StateObject private var notificationManager = NotificationManager.shared
    @State private var reminderTime: Date = Date()
    
    var body: some View {
        NavigationStack {
            Form {
                // 1. DOKUNSAL & SES AYARLARI
                Section(header: Text("DOKUNSAL & SES AYARLARI")) {
                    Toggle(isOn: $isHapticEnabled) {
                        Label("Dokunsal Geri Bildirim (Titreşim)", systemImage: "hand.tap.fill")
                    }
                    
                    Toggle(isOn: $isSoundEnabled) {
                        Label("Tık Ses Efekti", systemImage: "speaker.wave.2.fill")
                    }
                }
                
                // 2. YEREL BİLDİRİM AYARLARI (OFFLINE)
                Section(
                    header: Text("GÜNLÜK HATIRLATICI (ÇEVRİMDİŞI)"),
                    footer: Text("Belirlediğiniz saatte internet olmasa dahi cihazınız zikir saatinizi hatırlatır.")
                ) {
                    Toggle(isOn: $isReminderEnabled) {
                        Label("Günlük Zikir Hatırlatıcı", systemImage: "bell.badge.fill")
                    }
                    .onChange(of: isReminderEnabled) { _, newValue in
                        if newValue {
                            notificationManager.requestPermission { granted in
                                if granted {
                                    updateReminderTime()
                                } else {
                                    isReminderEnabled = false
                                }
                            }
                        } else {
                            notificationManager.cancelDailyReminder()
                        }
                    }
                    
                    if isReminderEnabled {
                        DatePicker("Hatırlatma Saati", selection: $reminderTime, displayedComponents: .hourAndMinute)
                            .onChange(of: reminderTime) { _, newDate in
                                let components = Calendar.current.dateComponents([.hour, .minute], from: newDate)
                                reminderHour = components.hour ?? 21
                                reminderMinute = components.minute ?? 0
                                updateReminderTime()
                            }
                    }
                }
                
                // 3. SOSYAL SORUMLULUK & CAN DOSTLARIMIZ
                Section(header: Text("CAN DOSTLARIMIZA DESTEK 🐾")) {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 8) {
                            Image(systemName: "pawprint.fill")
                                .foregroundStyle(Theme.primaryGreenColor)
                            Text("Mutlu Patiler (Kars)")
                                .font(.system(.body, design: .serif))
                                .bold()
                        }
                        
                        Text("Kars'taki can dostlarımıza mama ve tedavi desteği sağlayan Mutlu Patiler ekibine siz de destek olabilirsiniz. Bir kap mama, bir can kurtarır.")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        if let url = URL(string: "https://www.instagram.com/mutlupatiler.app/") {
                            Link(destination: url) {
                                HStack {
                                    Image(systemName: "heart.fill")
                                        .foregroundColor(.red)
                                    Text("Mutlu Patiler Instagram Sayfası")
                                        .font(.caption)
                                        .bold()
                                    Spacer()
                                    Image(systemName: "arrow.up.right")
                                        .font(.caption2)
                                }
                                .padding(10)
                                .background(Theme.primaryGreenColor.opacity(0.1))
                                .foregroundColor(Theme.primaryGreenColor)
                                .cornerRadius(10)
                            }
                            .padding(.top, 4)
                        }
                    }
                    .padding(.vertical, 4)
                }
                
                // 4. UYGULAMA BİLGİSİ
                Section(header: Text("UYGULAMA HAKKINDA")) {
                    HStack {
                        Text("Uygulama Adı")
                        Spacer()
                        Text("Tesbihat Günlüğüm")
                            .font(.system(.body, design: .serif))
                            .bold()
                    }
                    
                    HStack {
                        Text("Sürüm")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.gray)
                    }
                    
                    HStack {
                        Text("Not")
                        Spacer()
                        Text("Fezayir Yamen Hayrına")
                            .font(.subheadline)
                            .bold()
                            .foregroundStyle(Theme.primaryGreenColor)
                    }
                }
            }
            .navigationTitle("Ayarlar")
            .onAppear {
                var components = DateComponents()
                components.hour = reminderHour
                components.minute = reminderMinute
                if let date = Calendar.current.date(from: components) {
                    reminderTime = date
                }
            }
        }
    }
    
    private func updateReminderTime() {
        notificationManager.scheduleDailyReminder(
            hour: reminderHour,
            minute: reminderMinute
        )
    }
}
