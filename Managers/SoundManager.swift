import AudioToolbox
import Foundation

final class SoundManager {
    static let shared = SoundManager()
    
    private init() {}
    
    /// Sayım anında hafif tık sesi (Sistem ses ID: 1104 - Tock)
    func playClickSound(enabled: Bool = true) {
        guard enabled else { return }
        AudioServicesPlaySystemSound(1104)
    }
    
    /// Hedef tamamlandığında başarı sesi (Sistem ses ID: 1054 - KeyClick)
    func playCompletionSound(enabled: Bool = true) {
        guard enabled else { return }
        AudioServicesPlaySystemSound(1054)
    }
}
