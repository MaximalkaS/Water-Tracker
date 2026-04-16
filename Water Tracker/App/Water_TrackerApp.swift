
import SwiftUI

@main
struct Water_TrackerApp: App {
    
    @State var path = NavigationPath()
    private let persistenceController = PersistenceController.shared
    
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
            .environment(\.managedObjectContext,
                          persistenceController.container.viewContext)
        }
    }
}
