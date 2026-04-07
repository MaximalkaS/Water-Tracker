
import SwiftUI

struct WaterProgressRing: View {
    let consumed: Double
    let goal: Double
    
    var progress: Double {
        consumed / goal
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            Circle()
                .stroke(.applightBlue, lineWidth: 15)
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(.appBlue, style: StrokeStyle(lineWidth: 15, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut, value: progress)
            
            VStack(spacing: 5) {
                Text("\(Int(consumed)) / \(Int(goal)) ml")
                    .font(.statValue)
                    .foregroundStyle(.appBlack)
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 150, height: 1)
                    .foregroundStyle(.appGray)
                
                Text("\(Int(progress * 100))% of goal")
                    .font(.headlineSecondary)
                    .foregroundStyle(.appBlack)
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    WaterProgressRing(consumed: 1100, goal: 2500)
}
