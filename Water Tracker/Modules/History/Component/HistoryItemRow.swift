import SwiftUI

struct HistoryItemRow: View {
    
    let item: WaterEntryModel
    
    @State var dragOffSet = CGSize.zero
    @State var position = CGSize.zero
    
    let action: () -> Void
    
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
        
        .offset(x: dragOffSet.width + position.width)
        .animation(.linear, value: dragOffSet)
        .simultaneousGesture(
            DragGesture(minimumDistance: 25, coordinateSpace: .local)
                .onChanged { value in
                    let horizontal = value.translation.width
                    let vertical = value.translation.height
                    
                    guard abs(horizontal) > abs(vertical) else {
                        dragOffSet = .zero
                        return
                    }
                    
                    if horizontal < 0 {
                        dragOffSet.width = horizontal
                    } else if position.width < 0 {
                        dragOffSet.width = min(horizontal, abs(position.width))
                    } else {
                        dragOffSet.width = 0
                    }
                }
                .onEnded { value in
                    let horizontal = value.translation.width
                    let vertical = value.translation.height
                    
                    guard abs(horizontal) > abs(vertical) else {
                        dragOffSet = .zero
                        return
                    }
                    
                    withAnimation(.easeOut) {
                        if horizontal < -40 {
                            position.width = -50
                        } else {
                            position.width = 0
                        }
                    }
                    
                    dragOffSet = .zero
                }
        )
        
        .background(alignment: .trailing) {
            Button {
                action()
            } label: {
                Image(.deleteIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .padding(10)
                    .background(.appRed, in: .circle)
            }

        }
    }
}

#Preview {
    HistoryItemRow(item: WaterEntryModel(id: "s", remaining: 123, amount: 100, dailyGoalAtMoment: 1500, createdAt: Date()), action: {})
}
