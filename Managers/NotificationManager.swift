import Foundation
import UserNotifications

final class NotificationManager: ObservableObject {
    static let shared = NotificationManager()
    
    @Published var isPermissionGranted: Bool = false
    
    private init() {
        checkPermission()
    }
    
    /// Bildirim izni iste
    func requestPermission(completion: @escaping (Bool) -> Void = { _ in }) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            DispatchQueue.main.async {
                self.isPermissionGranted = granted
                completion(granted)
            }
        }
    }
    
    /// İzin durumunu kontrol et
    func checkPermission() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.isPermissionGranted = (settings.authorizationStatus == .authorized)
            }
        }
    }
    
    /// Günlük zikir hatırlatıcısı ayarla (%100 offline yerel bildirim)
    func scheduleDailyReminder(hour: Int, minute: Int, title: String = "Tesbihat Vakti", body: String = "Bugünkü zikrinizi tamamlamayı ve halkanızı büyütmeyi unutmayın.") {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: ["daily_dhikr_reminder"])
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "daily_dhikr_reminder", content: content, trigger: trigger)
        
        center.add(request) { error in
            if let error = error {
                print("Bildirim kurulamadı: \(error.localizedDescription)")
            }
        }
    }
    
    /// Günlük bildirimleri iptal et
    func cancelDailyReminder() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["daily_dhikr_reminder"])
    }
}
