
import Foundation

class MainViewModel: ObservableObject {
    @Published var dailyIntake: Double = 0
    @Published var goal: Double = 0
    @Published var dateString: String = Date().formattedMonthDay()
    
    private let storage: WaterStorageProtocol
    
    init(storage: WaterStorageProtocol = WaterStorage()) {
        self.storage = storage
    }
    
    func reloadData() {
        dailyIntake = Double(storage.dailyIntake)
        goal = Double(storage.dailyGoal)
    }
    
}
