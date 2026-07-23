import SwiftUI

struct ConfettiParticle: Identifiable {
    let id = UUID()
    var x: Double
    var y: Double
    var color: Color
    var size: CGFloat
    var speed: Double
    var angle: Double
}

struct ConfettiView: View {
    @State private var particles: [ConfettiParticle] = []
    let timer = Timer.publish(every: 0.03, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(particles) { particle in
                    Circle()
                        .fill(particle.color)
                        .frame(width: particle.size, height: particle.size)
                        .position(x: particle.x, y: particle.y)
                        .opacity(particle.y > geometry.size.height ? 0 : 1)
                }
            }
            .onAppear {
                spawnParticles(in: geometry.size)
            }
            .onReceive(timer) { _ in
                updateParticles(in: geometry.size)
            }
        }
        .allowsHitTesting(false)
    }
    
    private func spawnParticles(in size: CGSize) {
        let colors: [Color] = [Theme.primaryGreenColor, Theme.secondaryGreenColor, .orange, .green, .mint, .yellow]
        var newParticles: [ConfettiParticle] = []
        
        for _ in 0..<75 {
            let particle = ConfettiParticle(
                x: Double.random(in: 0...size.width),
                y: Double.random(in: -100...0),
                color: colors.randomElement() ?? Theme.primaryGreenColor,
                size: CGFloat.random(in: 6...14),
                speed: Double.random(in: 3...8),
                angle: Double.random(in: -0.2...0.2)
            )
            newParticles.append(particle)
        }
        particles = newParticles
    }
    
    private func updateParticles(in size: CGSize) {
        for i in 0..<particles.count {
            particles[i].y += particles[i].speed
            particles[i].x += particles[i].angle * 2
        }
    }
}
