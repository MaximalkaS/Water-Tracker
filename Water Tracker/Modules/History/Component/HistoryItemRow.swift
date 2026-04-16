
import SwiftUI

struct HistoryItemRow: View {
    
    let item: WaterEntryModel
    
    var remainingWaterText: String {
        if item.dailyGoalAtMoment - item.remaining <= 0{
            return "The daily goal is completed"
        } else {
            return "\(item.dailyGoalAtMoment - item.remaining)ml left"
        }
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            HStack(spacing: 10) {
                Image(.waterDropIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("\(item.amount)ml")
                        .font(.bodySemiBold)
                        .foregroundStyle(.appBlack)
                    
                    Text(remainingWaterText)
                        .font(.bodyRegular)
                        .foregroundStyle(.appGray)
                }
            }
            
            Spacer()
            
            Text(item.createdAt.formattedTime())
                .font(.bodyRegular)
                .foregroundStyle(.appGray)
        }
        .padding(10)
        .background(.appWhite)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.07), radius: 4)
    }
}
