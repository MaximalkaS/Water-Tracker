
import SwiftUI

struct AddWaterView: View {
    
    @StateObject var viewModel = AddWaterViewModel()
    @State private var selectedOptionID: String = WaterOption.medium.rawValue
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Button {
                    //
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
                    //
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
        .background(.appBackground)
    }
}

#Preview {
    AddWaterView()
}
