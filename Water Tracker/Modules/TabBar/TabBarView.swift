
import SwiftUI

struct TabBarView: View {
    
    @State private var selectedTab: TabItem = .main
    
    var body: some View {
        ZStack {
            MainView()
                .opacity(selectedTab == .main ? 1 : 0)
            
            MainView()
                .opacity(selectedTab == .statistics ? 1 : 0)
            
            MainView()
                .opacity(selectedTab == .history ? 1 : 0)
            
            MainView()
                .opacity(selectedTab == .setting ? 1 : 0)
        }
        .safeAreaInset(edge: .bottom) {
            CustomTabBar(selectedTab: $selectedTab)
                .padding(.horizontal, 20)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

#Preview {
    TabBarView()
}

