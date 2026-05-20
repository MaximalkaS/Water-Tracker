
import SwiftUI

struct TabBarView: View {
    
    @Binding var path: NavigationPath
    @State private var selectedTab: TabItem = .main
    
    var body: some View {
        ZStack {
            MainView(path: $path, selectedTab: selectedTab)
                .opacity(selectedTab == .main ? 1 : 0)
            
            StatisticsView(selectedTab: selectedTab)
                .opacity(selectedTab == .statistics ? 1 : 0)
            
            HistoryView()
                .opacity(selectedTab == .history ? 1 : 0)
            
            SettingView()
                .opacity(selectedTab == .setting ? 1 : 0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .bottom) {
            CustomTabBar(selectedTab: $selectedTab)
                .padding(.horizontal, 20)
                .padding(.bottom, 8)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

