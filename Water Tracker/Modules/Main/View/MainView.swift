
import SwiftUI

struct MainView: View {
    
    @Binding var path: NavigationPath
    
    @StateObject var viewModel = MainViewModel()

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 50) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Water Tracker")
                        .font(.headlinePrimary)
                        .foregroundStyle(.appBlack)
                    
                    Text("Today, \(viewModel.dateString)")
                        .font(.headlineSub)
                        .foregroundStyle(.appBlack)
                }
                
                WaterProgressRing(consumed: viewModel.dailyIntake, goal: viewModel.goal)
                
                Button {
                    path.append(WindowCase.addWater)
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
        .scrollBounceBehavior(.basedOnSize)
        .background(.appBackground)
        
        .onAppear {
            viewModel.reloadData()
        }
    }
}
