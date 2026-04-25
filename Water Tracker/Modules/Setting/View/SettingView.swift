
import SwiftUI

struct SettingView: View {
    @State private var dailyGoal: String = ""
    @FocusState private var isFocused: Bool
    
    @StateObject private var viewModel = SettingViewModel()
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 30) {
                Text("Settings")
                    .font(.headlinePrimary)
                    .foregroundStyle(.appBlack)
                VStack(alignment: .leading, spacing: 20) {
                    DailyGoalCard(dailyGoal: $dailyGoal, isFocused: $isFocused)
                    
                    VStack(alignment: .leading, spacing: 20) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Portion Volume")
                                .font(.headlineSecondary)
                                .foregroundStyle(.appBlack)
                            
                            Text("Set standard drink volumes in milliliters")
                                .font(.bodyRegular)
                                .foregroundStyle(.appBlack)
                        }
                        
                        ForEach(viewModel.waterOptions) { option in
                            
                        }
                        
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 15)
                    .background(.appWhite)
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.07), radius: 4)
                    
                }
            }
            .padding(.horizontal, 20)
        }
        .scrollBounceBehavior(.basedOnSize)
        .background(.appBackground)
        .onTapGesture {
            isFocused = false
            validation()
        }
        .onAppear {
            viewModel.reloadData()
            dailyGoal = "\(viewModel.waterDayLimit)"
        }
    }
    
    private func validation() {
        guard let limit = Int(dailyGoal) else {
            dailyGoal = "1500"
            viewModel.setWaterDayLimit(1500)
            return
        }
        
        if limit == 0 {
            dailyGoal = "1500"
            viewModel.setWaterDayLimit(1500)
        } else if limit < 1500 {
            dailyGoal = "1500"
            viewModel.setWaterDayLimit(1500)
        } else {
            dailyGoal = "\(limit)"
            viewModel.setWaterDayLimit(limit)
        }
    }
}

#Preview {
    SettingView()
}
