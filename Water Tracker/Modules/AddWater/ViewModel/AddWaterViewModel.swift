
import Foundation

class AddWaterViewModel: ObservableObject {
    @Published var waterOptions: [WaterOptionCardModel] = []
    
    private let storage: WaterStorageProtocol
    private let coreDataManager: CoreDataManagerProtocol
    
    init(storage: WaterStorageProtocol = WaterStorage(), coreDataManager: CoreDataManagerProtocol = CoreDataManager.shared) {
        self.storage = storage
        self.coreDataManager = coreDataManager
        loadData()
    }
    
    private func loadData() {
        waterOptions = WaterOptionMapper.makeCardModels(storage: storage)
    }
    
    func addWaterAmount(_ amount: Int) {
        storage.dailyIntake += amount
        
        let entry = WaterEntryModel(id: UUID().uuidString,
                                    remaining: storage.dailyIntake,
                                    amount: amount,
                                    dailyGoalAtMoment: storage.dailyGoal,
                                    createdAt: Date())
        
        coreDataManager.addWaterEntry(for: entry)
    }
    
    func getAmount(for option: WaterOption) -> Int {
        storage.getAmount(for: option)
    }
    
}
