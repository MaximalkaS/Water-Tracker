
import Foundation

class AddWaterViewModel: ObservableObject {
    @Published var waterOptions: [WaterOptionCardModel] = []
    
    private let storage: WaterStorageProtocol
    
    init(storage: WaterStorageProtocol = WaterStorage()) {
        self.storage = storage
        loadData()
    }
    
    private func loadData() {
        waterOptions = WaterOptionMapper.makeCardModels(storage: storage)
    }
    
    func addWaterAmount(_ amount: Int) {
        storage.dailyIntake += amount
    }
    
    func getAmount(for option: WaterOption) -> Int {
        storage.getAmount(for: option)
    }
}
