
import SwiftUI

extension CustomTabBar {
    func tabItem(_ tab: TabItem) -> some View {
        Button {
            selectedTab = tab
        } label: {
            Image(selectedTab == tab ? "\(tab)FillIcon" : "\(tab)Icon")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
        }
    }
}
