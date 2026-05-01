
import SwiftUI

struct HistoryView: View {
    
    @StateObject var viewModel = HistoryViewModel()
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 30) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Hydration History")
                        .font(.headlinePrimary)
                        .foregroundStyle(.appBlack)
                    
                    Text("Track your daily water intake")
                        .font(.headlineSub)
                        .foregroundStyle(.appBlack)
                }
                
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(viewModel.history) { history in
                        Text(history.date)
                            .font(.headlineSecondary)
                            .foregroundStyle(.appBlack)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            ForEach(history.items) { item in
                                HistoryItemRow(item: item) {
                                    viewModel.deleteWaterEntry(item)
                                }
                                .transition(.move(edge: .trailing))
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
        }
        .scrollBounceBehavior(.basedOnSize)
        .background(.appBackground)
        
        .onAppear {
            viewModel.loadData()
        }
    }
}

#Preview {
    HistoryView()
}
