import Foundation

class StatisticsViewModel: ObservableObject {
    @Published var weekItems: [WeekWaterModel] = []
    @Published var remaining: Int = 0
    @Published var goal: Int = 0

    private let coreData: CoreDataManagerProtocol
    private let storage: WaterStorageProtocol

    init(
        coreData: CoreDataManagerProtocol = CoreDataManager.shared,
        storage: WaterStorageProtocol = WaterStorage()
    ) {
        self.coreData = coreData
        self.storage = storage
    }

    func loadData() {
        let calendar = Calendar.current
        let now = Date()

        guard
            let weekInterval = calendar.dateInterval(of: .weekOfYear, for: now)
        else {
            return
        }

        let entries = coreData.fetchWaterEntries(
            from: weekInterval.start, to: weekInterval.end)
        weekItems = WeekWaterMapper.makeCurrentWeek(from: entries)

        goal = storage.dailyGoal
        
        let remainingWater = storage.dailyGoal - storage.dailyIntake
        if remainingWater <= 0 {
            remaining = 0
        } else {
            remaining = remainingWater
        }
        
    }
}
