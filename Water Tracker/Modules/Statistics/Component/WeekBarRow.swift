import SwiftUI

struct WeekBarRow: View {

    let totalAmount: Int
    let dailyGoal: Int
    let day: String

    private let barHeight: CGFloat = 400

    private var progress: CGFloat {
        guard dailyGoal > 0 else { return 0 }
        return min(CGFloat(totalAmount) / CGFloat(dailyGoal), 1)
    }
    
    private var isCompleted: Bool {
        if dailyGoal == 0 {
            return false
        } else {
            return totalAmount >= dailyGoal
        }
    }

    var body: some View {
        VStack(spacing: 10) {
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 25)
                    .fill(.appLightBlue)
                    .frame(height: barHeight)
                
                RoundedRectangle(cornerRadius: 25)
                    .fill(.appBlue)
                    .frame(height: barHeight * progress)
                    .overlay(alignment: .top) {
                        if isCompleted {
                            Image(.checkMarkIcon)
                                .resizable()
                                .scaledToFit()
                                .padding(3)
                        }
                    }
            }

            Text(day)
                .font(.bodyRegular)
                .foregroundStyle(.appGray)
        }
    }
}
