
import SwiftUI

struct TabBarView: View {
    
    @Binding var path: NavigationPath
    @State private var selectedTab: TabItem = .main
    
    var body: some View {
        ZStack {
            MainView(path: $path, selectedTab: selectedTab)
                .opacity(selectedTab == .main ? 1 : 0)
            
            StatisticsView()
                .opacity(selectedTab == .statistics ? 1 : 0)
            
            HistoryView()
                .opacity(selectedTab == .history ? 1 : 0)
            
            SettingView()
                .opacity(selectedTab == .setting ? 1 : 0)
        }
        .safeAreaInset(edge: .bottom) {
            CustomTabBar(selectedTab: $selectedTab)
                .padding(.horizontal, 20)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

