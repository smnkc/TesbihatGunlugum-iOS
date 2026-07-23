import SwiftUI
import SwiftData

struct CounterView: View {
    @Bindable var event: EtkinlikModel
    @Environment(\.modelContext) private var modelContext
    
    @Environment(\.colorScheme) private var colorScheme
    private var isDarkMode: Bool { colorScheme == .dark }
    
    @AppStorage("isSoundEnabled") private var isSoundEnabled: Bool = true
    @AppStorage("isHapticEnabled") private var isHapticEnabled: Bool = true
    
    @State private var isLocked: Bool = false
    @State private var showCompletionAlert: Bool = false
    @State private var showResetConfirm: Bool = false
    
    // Metin Uzunluğuna Göre Maksimum Büyüyen Akıllı Punto Boyutu
    private func fontSizeForPronunciation(_ text: String) -> CGFloat {
        if text.count > 160 { return 17.5 }
        if text.count > 60 { return 20.5 }
        return 24.0 // Kısa ve orta metinler alanı en güzel dolduracak şekilde büyük
    }
    
    var body: some View {
        ZStack {
            // Net Zemin (Tüm Ekran Dokunma Alanı)
            Theme.backgroundGradient(isDarkMode: isDarkMode)
                .ignoresSafeArea()
                .contentShape(Rectangle())
                .onTapGesture {
                    handleScreenTap()
                }
            
            VStack(spacing: 0) {
                // 1. DÜZENLİ ÜST KART
                HStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 3) {
                        HStack(alignment: .center, spacing: 6) {
                            Image(systemName: event.isSet ? "square.stack.3d.up.fill" : "sparkles")
                                .foregroundStyle(Theme.primaryGreenColor)
                            Text(event.activeTitle)
                                .font(.system(.title3, design: .serif).weight(.bold))
                                .foregroundStyle(isDarkMode ? .white : Theme.darkSlateColor)
                                .lineLimit(1)
                                .minimumScaleFactor(0.8)
                                .contentTransition(.numericText())
                                .animation(.easeInOut, value: event.activeTitle)
                        }
                        
                        Text("Hedef: \(event.targetCount.formatted()) Tekrar")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                        
                        if let note = event.note, !note.isEmpty {
                            Text("Niyet: \(note)")
                                .font(.caption)
                                .italic()
                                .foregroundStyle(.secondary)
                                .lineLimit(1)
                        }
                    }
                    
                    Spacer()
                    
                    // Kilit Modu Butonu
                    Button {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            isLocked.toggle()
                        }
                        if isHapticEnabled { HapticManager.shared.undoTap() }
                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: isLocked ? "lock.fill" : "lock.open.fill")
                            Text(isLocked ? "Kilitli" : "Kilitle")
                                .font(.caption2)
                                .bold()
                        }
                        .foregroundStyle(isLocked ? Color.red : Theme.primaryGreenColor)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(isLocked ? Color.red.opacity(0.12) : Theme.primaryGreenColor.opacity(0.12))
                        .clipShape(Capsule())
                    }
                }
                .glassCard(isDarkMode: isDarkMode)
                .padding(.horizontal)
                .padding(.top, 6)
                
                // 2. MAKSİMUM BÜTÜN ALANI DOLDURAN ORTALANMIŞ VE %100 TIKLANABİLİR OKUMA BANNER'I
                VStack {
                    Spacer(minLength: 0)
                    
                    if let pron = event.activePronunciation, !pron.isEmpty {
                        Text("“\(pron)”")
                            .font(.system(size: fontSizeForPronunciation(pron), weight: .semibold, design: .serif))
                            .lineSpacing(3)
                            .foregroundStyle(Theme.primaryGreenColor)
                            .multilineTextAlignment(.center)
                            .minimumScaleFactor(0.5)
                            .lineLimit(6)
                            .padding(.horizontal, 16)
                    }
                    
                    Spacer(minLength: 0)
                }
                .frame(maxHeight: .infinity)
                .contentShape(Rectangle())
                .onTapGesture {
                    handleScreenTap()
                }
                
                // 3. MERKEZİ SABİT SAYAÇ HALKASI
                ZStack {
                    ProgressRingView(progress: event.progressPercentage)
                        .frame(width: 275, height: 275)
                    
                    VStack(spacing: 6) {
                        Text(event.isSet ? "ADIM KALANI" : "KALAN TEKRAR")
                            .font(.system(size: 12, weight: .bold, design: .monospaced))
                            .foregroundStyle(Theme.secondaryGreenColor)
                            .tracking(2)
                        
                        // OTOMATİK ÖLÇEKLENEN SAYI
                        Text("\(event.remainingCount.formatted())")
                            .font(.system(size: fontSizeForCount(event.remainingCount), weight: .bold, design: .serif))
                            .foregroundStyle(isDarkMode ? .white : Theme.darkSlateColor)
                            .minimumScaleFactor(0.3)
                            .lineLimit(1)
                            .frame(maxWidth: 240)
                            .contentTransition(.numericText(value: Double(event.remainingCount)))
                            .animation(.snappy, value: event.remainingCount)
                        
                        Text("\(event.currentCount.formatted()) / \(event.targetCount.formatted())")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                            .minimumScaleFactor(0.7)
                        
                        Text("%\(Int(event.progressPercentage * 100)) Tamamlandı")
                            .font(.caption)
                            .bold()
                            .foregroundStyle(Theme.primaryGreenColor)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background(Theme.primaryGreenColor.opacity(0.1))
                            .cornerRadius(8)
                    }
                    .padding(.horizontal, 20)
                }
                .contentShape(Circle())
                .onTapGesture {
                    handleScreenTap()
                }
                .overlay(
                    Group {
                        if isLocked {
                            Circle()
                                .stroke(Color.red.opacity(0.4), lineWidth: 3)
                                .overlay(
                                    Text("EKRAN KİLİTLİ")
                                        .font(.caption2)
                                        .bold()
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 4)
                                        .background(Color.red)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                        .offset(y: 128)
                                )
                        }
                    }
                )
                
                Spacer(minLength: 16)
                
                // 4. AKSİYON BAR
                HStack(spacing: 12) {
                    // Geri Al (-1) (Özel Geri Alma Durumu)
                    Button {
                        decrementTap()
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: "arrow.uturn.backward")
                            Text("Geri Al (-1)")
                        }
                        .font(.system(size: 13, weight: .semibold))
                        .frame(maxWidth: .infinity, minHeight: 46)
                        .background(isDarkMode ? Color.white.opacity(0.1) : Color.white)
                        .foregroundStyle(isDarkMode ? .white : Theme.darkSlateColor)
                        .cornerRadius(16)
                        .shadow(color: Color.black.opacity(0.04), radius: 6, x: 0, y: 3)
                    }
                    .disabled(isLocked || event.currentCount == 0)
                    .opacity(isLocked || event.currentCount == 0 ? 0.4 : 1.0)
                    
                    // Sıfırla (KİLİTLİ İKEN SIFIRLAMA ONAYI AÇAR, KİLİTLİ DEĞİLKEN SAYAÇ İLERLETİR)
                    Button {
                        if isLocked {
                            showResetConfirm = true
                        } else {
                            handleScreenTap()
                        }
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: "arrow.counterclockwise")
                            Text("Sıfırla")
                        }
                        .font(.system(size: 13, weight: .semibold))
                        .frame(maxWidth: .infinity, minHeight: 46)
                        .background(isLocked && event.currentCount > 0 ? Color.red.opacity(0.12) : (isDarkMode ? Color.white.opacity(0.1) : Color.white))
                        .foregroundStyle(isLocked && event.currentCount > 0 ? Color.red : (isDarkMode ? .white : Theme.darkSlateColor))
                        .cornerRadius(16)
                        .shadow(color: Color.black.opacity(0.04), radius: 6, x: 0, y: 3)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 16)
            }
        }
        .alert("Tebrikler! 🎉", isPresented: $showCompletionAlert) {
            Button("Tamam", role: .cancel) {}
        } message: {
            Text("\(event.title) hedefinizi başarıyla tamamladınız!")
        }
        .confirmationDialog(
            "Sayacı Sıfırla",
            isPresented: $showResetConfirm,
            titleVisibility: .visible
        ) {
            Button("Sayacı Sıfırla", role: .destructive) {
                resetCounter()
            }
            Button("İptal", role: .cancel) {}
        } message: {
            Text("Okuma sayınız sıfırlanacaktır. Bu işlem geri alınamaz.")
        }
    }
    
    private func fontSizeForCount(_ count: Int) -> CGFloat {
        if count > 999_999 { return 28 }
        if count > 99_999 { return 36 }
        if count > 9_999 { return 44 }
        return 56
    }
    
    private func handleScreenTap() {
        guard !isLocked && !event.isCompleted else { return }
        let previousCount = event.currentCount
        let previousStep = event.currentStepIndex
        
        event.increment()
        try? modelContext.save()
        
        if isSoundEnabled { SoundManager.shared.playClickSound() }
        
        if isHapticEnabled {
            if event.isCompleted {
                HapticManager.shared.completion()
                if isSoundEnabled { SoundManager.shared.playCompletionSound() }
                withAnimation {
                    showCompletionAlert = true
                }
            } else if event.isSet && event.currentStepIndex > previousStep {
                HapticManager.shared.milestone()
            } else if (event.currentCount % 100 == 0) && event.currentCount > previousCount {
                HapticManager.shared.milestone()
            } else {
                HapticManager.shared.countTap()
            }
        }
    }
    
    private func decrementTap() {
        guard !isLocked && event.currentCount > 0 else { return }
        event.decrement()
        try? modelContext.save()
        if isHapticEnabled { HapticManager.shared.undoTap() }
    }
    
    private func resetCounter() {
        event.currentCount = 0
        event.stepCurrentCount = 0
        event.currentStepIndex = 0
        event.isCompleted = false
        event.completedDate = nil
        try? modelContext.save()
        if isHapticEnabled { HapticManager.shared.undoTap() }
    }
}
