
import Foundation

class SettingViewModel: ObservableObject {
    @Published var waterDayLimit: Int = 0
    @Published var waterOptions: [WaterOptionCardModel] = []
    
    private let storage: WaterStorageProtocol
    
    init(storage: WaterStorageProtocol = WaterStorage()) {
        self.storage = storage
    }
    
    func reloadData() {
        waterDayLimit = storage.dailyGoal
        waterOptions = WaterOptionMapper.makeCardModels(storage: storage)
    }
    
    func setWaterDayLimit(_ limit: Int) {
        storage.dailyGoal = limit
    }
    
    func setAmount(_ amount: Int, for option: WaterOption) {
        storage.setAmount(amount, for: option)
    }
    
}
