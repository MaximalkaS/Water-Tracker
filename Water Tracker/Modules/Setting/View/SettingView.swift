
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
                        
                        HStack {
                            ForEach(Array($viewModel.waterOptions.enumerated()), id: \.element.id) { index, $option in
                                
                                WaterPortionSettingCard(option: $option, isFocused: $isFocused) {
                                    viewModel.setAmount(option.amount, for: WaterOption.waterOption(option.id))
                                }
                                
                                if index != viewModel.waterOptions.count - 1 {
                                    Rectangle()
                                        .frame(width: 1)
                                        .frame(maxHeight: .infinity)
                                        .foregroundColor(.appLightBlue)
                                        .padding(.vertical, 5)
                                }
                            }
                        }
                        .padding(.horizontal, 10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.appLightBlue, lineWidth: 1.5)
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
        .onChange(of: isFocused) { focused in
            if !focused {
                validation()
            }
        }
        .onAppear {
            viewModel.reloadData()
            dailyGoal = "\(viewModel.waterDayLimit)"
        }
        .onDisappear {
            validation()
        }
    }
    
    private func validation() {
        guard let limit = Int(dailyGoal) else {
            dailyGoal = "1500"
            viewModel.setWaterDayLimit(1500)
            return
        }

        let validLimit = min(max(limit, 1500), 5000)

        dailyGoal = "\(validLimit)"
        viewModel.setWaterDayLimit(validLimit)
    }
}

#Preview {
    SettingView()
}
