
import SwiftUI

struct CustomTabBar: View {
    
    @Binding var selectedTab: TabItem
    
    var body: some View {
        HStack {
            tabItem(.main)
            
            Spacer()
            
            tabItem(.statistics)
            
            Spacer()
            
            tabItem(.history)
            
            Spacer()
            
            tabItem(.setting)
        }
        .padding(.horizontal, 30)
        .frame(height: 50)
        .background(.appBlue)
        .cornerRadius(10)
    }
}

