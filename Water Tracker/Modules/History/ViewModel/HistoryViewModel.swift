
import Foundation

class HistoryViewModel: ObservableObject {
    @Published var history: [HistoryModel] = []
    
    private let coreData: CoreDataManagerProtocol
    
    init(coreData: CoreDataManagerProtocol = CoreDataManager.shared) {
        self.coreData = coreData
    }
    
    func loadData() {
        coreData.fetchWaterEntries()
        let groupedHistory = Dictionary(grouping: coreData.waterEntries) { item in
            Calendar.current.startOfDay(for: item.createdAt)
        }
        
        let sortedHistory = groupedHistory.sorted { $0.key > $1.key }
        
        history = sortedHistory.map { date, entries in
            let sortedEntries = entries.sorted { $0.createdAt > $1.createdAt }
            
            return HistoryModel(
                id: UUID().uuidString,
                date: title(date),
                items: sortedEntries.map { entry in
                    WaterEntryModel(
                        id: entry.id,
                        remaining: Int(entry.remaining),
                        amount: Int(entry.amount),
                        dailyGoalAtMoment: Int(entry.dailyGoalAtMoment),
                        createdAt: entry.createdAt
                    )
                }
            )
        }
    }
    
    private func title(_ date: Date) -> String {
        if Calendar.current.isDateInToday(date) {
            return "Today"
        } else {
            return date.formattedFullDate()
        }
    }
}
