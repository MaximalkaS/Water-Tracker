
import SwiftUI

struct WaterAmountCard: View {
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Image("smallDrinkImage")
                .resizable()
                .scaledToFit()
                .clipped()
                .frame(height: 60)
            
            VStack(spacing: 0) {
                Text("Small")
                    .font(.bodyRegular)
                    .foregroundStyle(.appBlack)
                
                Text("100ml")
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
    WaterAmountCard()
}
