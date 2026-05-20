
import SwiftUI

struct StatisticsView: View {
    
    @StateObject var viewModel = StatisticsViewModel()
    let selectedTab: TabItem
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .center, spacing: 50) {
                VStack(alignment: .center, spacing: 10) {
                    HStack(spacing: 10) {
                        Image(.waterDropIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 26)
                        HStack(alignment: .firstTextBaseline, spacing: 5) {
                            Text("\(viewModel.goal)")
                                .font(.headlinePrimary)
                                .foregroundStyle(.appBlack)
                            
                            Text("ml")
                                .font(.bodyLight)
                                .foregroundStyle(.appBlack)
                        }
                    }
                    
                    Text("You need \(viewModel.remaining) ml for today")
                        .font(.bodyLight)
                        .foregroundStyle(.appBlack)
                }
                
                HStack(spacing: 20) {
                    ForEach(viewModel.weekItems) { item in
                        WeekBarRow(totalAmount: item.totalAmount,
                                   dailyGoal: item.dailyGoal,
                                   day: item.dayName)
                    }
                }
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
        }
        .scrollBounceBehavior(.basedOnSize)
        .background(.appBackground)
        
        .onChange(of: selectedTab) { newValue in
            if newValue == .statistics {
                viewModel.loadData()
            }
        }
    }
}


