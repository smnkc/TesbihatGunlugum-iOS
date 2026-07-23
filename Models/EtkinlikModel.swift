import Foundation
import SwiftData

@Model
final class EtkinlikModel: Identifiable {
    var id: UUID = UUID()
    var title: String = ""
    var targetCount: Int = 1000
    var currentCount: Int = 0
    var note: String? = nil
    var turkishPronunciation: String? = nil
    var startDate: Date = Date()
    var completedDate: Date? = nil
    var isCompleted: Bool = false
    
    // ZİKİR SETİ DESTEĞİ
    var isSet: Bool = false
    var steps: [ZikirStep]? = nil
    var currentStepIndex: Int = 0
    var stepCurrentCount: Int = 0
    
    init(
        title: String,
        targetCount: Int,
        currentCount: Int = 0,
        note: String? = nil,
        turkishPronunciation: String? = nil,
        startDate: Date = Date(),
        completedDate: Date? = nil,
        isCompleted: Bool = false,
        isSet: Bool = false,
        steps: [ZikirStep]? = nil,
        currentStepIndex: Int = 0,
        stepCurrentCount: Int = 0
    ) {
        self.id = UUID()
        self.title = title
        self.targetCount = targetCount
        self.currentCount = currentCount
        self.note = note
        self.turkishPronunciation = turkishPronunciation
        self.startDate = startDate
        self.completedDate = completedDate
        self.isCompleted = isCompleted
        self.isSet = isSet
        self.steps = steps
        self.currentStepIndex = currentStepIndex
        self.stepCurrentCount = stepCurrentCount
    }
    
    // AKTİF BAŞLIK (SET İSE ADIM BAŞLIĞI)
    var activeTitle: String {
        if isSet, let steps = steps, currentStepIndex < steps.count {
            return steps[currentStepIndex].title
        }
        return title
    }
    
    // AKTİF OKUNUŞ (SET İSE ADIM OKUNUŞU)
    var activePronunciation: String? {
        if isSet, let steps = steps, currentStepIndex < steps.count {
            return steps[currentStepIndex].turkishPronunciation
        }
        return turkishPronunciation
    }
    
    // AKTİF ARAPÇA
    var activeArabicText: String? {
        if isSet, let steps = steps, currentStepIndex < steps.count {
            return steps[currentStepIndex].arabicText
        }
        return nil
    }
    
    // Yüzdelik İlerleme Oranı (0.0 - 1.0)
    var progressPercentage: Double {
        guard targetCount > 0 else { return 0.0 }
        return min(Double(currentCount) / Double(targetCount), 1.0)
    }
    
    // Kalan Tekrar Sayısı (Set ise Adım Kalanı)
    var remainingCount: Int {
        if isSet, let steps = steps, currentStepIndex < steps.count {
            let stepTarget = steps[currentStepIndex].targetCount
            return max(stepTarget - stepCurrentCount, 0)
        }
        return max(targetCount - currentCount, 0)
    }
    
    // Sayacı 1 Artırır
    func increment() {
        guard !isCompleted else { return }
        
        currentCount += 1
        
        if isSet, let steps = steps, currentStepIndex < steps.count {
            stepCurrentCount += 1
            let currentStepTarget = steps[currentStepIndex].targetCount
            
            if stepCurrentCount >= currentStepTarget {
                if currentStepIndex + 1 < steps.count {
                    currentStepIndex += 1
                    stepCurrentCount = 0
                } else {
                    isCompleted = true
                    completedDate = Date()
                }
            }
        } else {
            if currentCount >= targetCount {
                isCompleted = true
                completedDate = Date()
            }
        }
    }
    
    // Sayacı 1 Eksiltir
    func decrement() {
        guard currentCount > 0 else { return }
        
        currentCount -= 1
        
        if isSet, let steps = steps {
            if stepCurrentCount > 0 {
                stepCurrentCount -= 1
            } else if currentStepIndex > 0 {
                currentStepIndex -= 1
                stepCurrentCount = max(steps[currentStepIndex].targetCount - 1, 0)
            }
            if isCompleted {
                isCompleted = false
                completedDate = nil
            }
        } else {
            if isCompleted && currentCount < targetCount {
                isCompleted = false
                completedDate = nil
            }
        }
    }
    
    // Kaç günde tamamlandığı
    var completionDaysText: String {
        guard let endDate = completedDate else { return "Devam ediyor" }
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: startDate, to: endDate)
        let days = max(components.day ?? 1, 1)
        return "\(days) Günde"
    }
}
