
import SwiftUI

@main
struct Water_TrackerApp: App {
    
    @State var path = NavigationPath()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $path) {
                TabBarView(path: $path)
                    .navigationDestination(for: WindowCase.self) { view in
                        switch view {
                        case .addWater:
                            AddWaterView(path: $path)
                            
                        default:
                            EmptyView()
                        }
                    }
            }
        }
    }
}
