
import SwiftUI

@main
struct Water_TrackerApp: App {
    @Environment(\.scenePhase) private var scenePhase
    
    @State var path = NavigationPath()
    
    private let persistenceController = PersistenceController.shared
    @StateObject private var waterStorage = WaterStorage()
    
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
        .onChange(of: scenePhase) { _, newPhase in
            if newPhase == .active {
                waterStorage.resetIfNeeded()
            }
        }
    }
}
