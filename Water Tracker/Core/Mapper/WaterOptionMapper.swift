
import Foundation

struct WaterOptionMapper {
    static func makeCardModels(storage: WaterStorageProtocol) -> [WaterOptionCardModel] {
        WaterOption.allCases.map { option in
            WaterOptionCardModel(id: option.id,
                                 image: option.image,
                                 title: option.title,
                                 amount: storage.getAmount(for: option))
        }
    }
}
