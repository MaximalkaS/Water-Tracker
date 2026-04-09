
import Foundation

class MainViewModel: ObservableObject {
    @Published var dailyIntake: Double = 0
    @Published var goal: Double = 0
    
    private let storage: WaterStorageProtocol
    
    init(storage: WaterStorageProtocol = WaterStorage()) {
        self.storage = storage
        loadData()
    }
    
    private func loadData() {
        dailyIntake = Double(storage.dailyIntake)
        goal = Double(storage.dailyGoal)
    }
}
