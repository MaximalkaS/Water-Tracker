import SwiftUI

struct WaterPortionSettingCard: View {
    
    @Binding var option: WaterOptionCardModel
    @FocusState.Binding var isFocused: Bool

    let action: () -> Void
    
    var body: some View {
        VStack {
            VStack(alignment: .center, spacing: 5) {
                VStack(alignment: .center, spacing: 0) {
                    Image(option.image)
                        .resizable()
                        .scaledToFit()
                        .clipped()
                        .frame(height: 60)
                    
                    Text(option.title)
                        .font(.bodyRegular)
                        .foregroundStyle(.appBlack)
                }
                .padding(.top, 20)
                
                HStack {
                    TextField(
                        "",
                        text: Binding(
                            get: {
                                "\(option.amount)"
                            },
                            set: { newValue in
                                let filtered = newValue.filter { $0.isNumber }
                                
                                guard let amount = Int(filtered) else {
                                    option.amount = 0
                                    action()
                                    return
                                }
                                
                                option.amount = validatedAmount(
                                    amount: amount,
                                    option: WaterOption.waterOption(option.id)
                                )
                                
                                action()
                            }
                        )
                    )
                    .font(.bodyRegular)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.appBlack)
                    .frame(width: 50, height: 30)
                    .padding(.leading, 10)
                    .focused($isFocused)
                    .keyboardType(.numberPad)
                    .onChange(of: option.amount) { newValue in
                        //
                    }
                    
                    VStack {
                        Text("ml")
                            .font(.bodyRegular)
                            .foregroundStyle(.appBlack)
                    }
                    .frame(width: 30, height: 30)
                    .background(.appLightBlue)
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
                        .stroke(.appLightBlue, lineWidth: 1)
                }
                .padding(.bottom, 20)
            }
            .frame(maxWidth: .infinity)
        }
    }
    
    private func validatedAmount(amount: Int, option: WaterOption) -> Int {
        switch option {
        case .small:
            return min(max(amount, 100), 200)
        case .medium:
            return min(max(amount, 200), 300)
        case .large:
            return min(max(amount, 300), 500)
        }
    }
    
    private func maxAllowedAmount(for option: WaterOption) -> Int {
        switch option {
        case .small:
            return 200
        case .medium:
            return 300
        case .large:
            return 500
        }
    }
}

