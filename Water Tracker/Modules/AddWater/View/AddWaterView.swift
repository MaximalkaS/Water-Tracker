
import SwiftUI

struct AddWaterView: View {
    
    @Binding var path: NavigationPath
    @StateObject var viewModel = AddWaterViewModel()
    
    @State private var selectedOptionID: String = WaterOption.medium.rawValue
    
    private var selectedAmount: Int {
        viewModel.waterOptions.first { $0.id == selectedOptionID }?.amount ?? 0
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Button {
                    path.removeLast()
                } label: {
                    Image(.backArrowIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Log Water")
                        .font(.headlinePrimary)
                        .foregroundStyle(.appBlack)
                    
                    Text("Log your hydration in here")
                        .font(.headlineSub)
                        .foregroundStyle(.appBlack)
                }
                
                VStack(alignment: .leading, spacing: 15) {
                    Text("Water Type")
                        .font(.headlineSecondary)
                        .foregroundStyle(.appBlack)
                    
                    HStack(spacing: 15) {
                        ForEach(viewModel.waterOptions) { option in
                            WaterOptionCard(option: option, isSelected: selectedOptionID == option.id)
                                .onTapGesture {
                                    selectedOptionID = option.id
                                }
                                .animation(.smooth)
                        }
                    }
                }
                
                Button {
                    path.removeLast()
                    viewModel.addWaterAmount(selectedAmount)
                } label: {
                    VStack {
                        Text("Add")
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
        
        .navigationBarBackButtonHidden(true)
        .toolbarBackground(.hidden, for: .navigationBar)
    }
}

