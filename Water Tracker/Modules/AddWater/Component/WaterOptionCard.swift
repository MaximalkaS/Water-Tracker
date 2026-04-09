
import SwiftUI

struct WaterOptionCard: View {
    
    let option: WaterOptionCardModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Image(option.image)
                .resizable()
                .scaledToFit()
                .clipped()
                .frame(height: 60)
            
            VStack(spacing: 0) {
                Text(option.title)
                    .font(.bodyRegular)
                    .foregroundStyle(.appBlack)
                
                Text("\(option.amount)ml")
                    .font(.bodyCaption)
                    .foregroundStyle(.appGray)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 170)
        .background(.appWhite)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.07), radius: 4)
    }
}

#Preview {
    WaterOptionCard(option: WaterOptionCardModel(id: "1",image: "smallDrinkImage", title: "Small", amount: 100))
}
