
import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel = MainViewModel()

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 50) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Water Tracker")
                        .font(.headlinePrimary)
                        .foregroundStyle(.appBlack)
                    
                    Text("Today, April 21")
                        .font(.headlineSub)
                        .foregroundStyle(.appBlack)
                }
                
                WaterProgressRing(consumed: viewModel.dailyIntake, goal: viewModel.goal)
                
                Button {
                    //
                } label: {
                    VStack {
                        Text("Log Water")
                            .font(.buttonLabel)
                            .foregroundStyle(.appWhite)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .background(.appBlue)
                    .cornerRadius(10)
                }

            }
            .padding(.horizontal, 20)
        }
        .background(.appBackground)
    }
}

#Preview {
    MainView()
}
