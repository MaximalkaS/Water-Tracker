
import SwiftUI

struct DailyGoalCard: View {
    
    @Binding var dailyGoal: String
    @FocusState.Binding var isFocused: Bool
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Text("Daily Goal")
                .font(.headlineSecondary)
                .foregroundStyle(.appBlack)
            
            Spacer()
            
            HStack {
                TextField(
                    "",
                    text: $dailyGoal
                )
                .font(.bodyRegular)
                .multilineTextAlignment(.center)
                .foregroundStyle(.appBlue)
                .frame(width: 80, height: 30)
                .padding(.leading, 10)
                .focused($isFocused)
                .keyboardType(.numberPad)
                .onChange(of: dailyGoal) { value in
                    let filtered = value.filter { $0.isNumber }
                    
                    if filtered != value {
                        dailyGoal = filtered
                        return
                    }
                    
                    if let number = Int(filtered) {
                        let normalized = String(number)
                        
                        if normalized != value {
                            dailyGoal = normalized
                        }
                    }
                    
                    if let number = Int(dailyGoal), number > 5000 {
                        dailyGoal = "5000"
                    }
                }
                
                VStack {
                    Text("ml")
                        .font(.bodyRegular)
                        .foregroundStyle(.appWhite)
                }
                .frame(width: 30, height: 30)
                .background(.appBlue)
                .clipShape(
                    UnevenRoundedRectangle(
                        topLeadingRadius: 0,
                        bottomLeadingRadius: 0,
                        bottomTrailingRadius: 10,
                        topTrailingRadius: 10
                    )
                )
            }
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.appBlue, lineWidth: 1)
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 15)
        .background(.appWhite)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.07), radius: 4)
    }
}
