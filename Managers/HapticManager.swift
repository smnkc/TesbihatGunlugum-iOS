#if canImport(UIKit)
import UIKit
#else
import Foundation
#endif

final class HapticManager {
    static let shared = HapticManager()
    
    private init() {}
    
    /// Normal dokunuş haptiği (hafif dokunuş)
    func countTap() {
        #if canImport(UIKit)
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.prepare()
        generator.impactOccurred()
        #endif
    }
    
    /// Geri al (-1) haptiği
    func undoTap() {
        #if canImport(UIKit)
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred()
        #endif
    }
    
    /// Tur / 100'lü veya 1000'li baraj tamamlama haptiği
    func milestone() {
        #if canImport(UIKit)
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(.warning)
        #endif
    }
    
    /// Ana hedef tamamlama haptiği (özel kutlama ritmi)
    func completion() {
        #if canImport(UIKit)
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(.success)
        
        // Ritmi hissettirmek için 0.2sn sonra ikinci vuruş
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            let impact = UIImpactFeedbackGenerator(style: .heavy)
            impact.impactOccurred()
        }
        #endif
    }
}

