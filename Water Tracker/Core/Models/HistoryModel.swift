
import Foundation

struct HistoryModel: Identifiable {
    let id: String
    let date: String
    let items: [WaterEntryModel]
}
