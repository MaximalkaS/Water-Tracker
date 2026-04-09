
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
}
