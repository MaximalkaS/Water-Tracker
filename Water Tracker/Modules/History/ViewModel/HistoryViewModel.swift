
import Foundation

class HistoryViewModel: ObservableObject {
    @Published var history: [HistoryModel] = []
    
    private let coreData: CoreDataManagerProtocol
    private let storage: WaterStorageProtocol
    
    init(coreData: CoreDataManagerProtocol = CoreDataManager.shared, storage: WaterStorageProtocol = WaterStorage()) {
        self.coreData = coreData
        self.storage = storage
    }
    
    func loadData() {
        coreData.fetchWaterEntries()
        let validEntries = coreData.waterEntries.compactMap { entry -> WaterEntryModel? in
            guard let id = entry.id, let createdAt = entry.createdAt else {
                return nil
            }
            
            return WaterEntryModel(
                id: id,
                remaining: Int(entry.remaining),
                amount: Int(entry.amount),
                dailyGoalAtMoment: Int(entry.dailyGoalAtMoment),
                createdAt: createdAt
            )
        }
        
        let groupedHistory = Dictionary(grouping: validEntries) { item in
            Calendar.current.startOfDay(for: item.createdAt)
        }
        
        let sortedHistory = groupedHistory.sorted { $0.key > $1.key }
        
        history = sortedHistory.map { date, entries in
            let sortedEntries = entries.sorted { $0.createdAt > $1.createdAt }
            
            return HistoryModel(
                id: UUID().uuidString,
                date: title(date),
                items: sortedEntries
            )
        }
    }
    
    func deleteWaterEntry(_ entry: WaterEntryModel) {
        coreData.deleteWaterEntry(with: entry.id)
        if Calendar.current.isDateInToday(entry.createdAt) {
            storage.dailyIntake = storage.dailyIntake - entry.amount
        }
        loadData()
    }
    
    private func title(_ date: Date) -> String {
        if Calendar.current.isDateInToday(date) {
            return "Today"
        } else {
            return date.formattedFullDate()
        }
    }
}
