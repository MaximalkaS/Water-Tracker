import Foundation

struct WeekWaterMapper {
    
    static func makeCurrentWeek(from entries: [WaterEntry]) -> [WeekWaterModel] {
        let calendar = Calendar.current
        let now = Date()
        
        guard let weekInterval = calendar.dateInterval(of: .weekOfYear, for: now) else {
            return []
        }
        
        let startOfWeek = weekInterval.start
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "E"
        
        var result: [WeekWaterModel] = []
        
        for dayIndex in 0..<7 {
            guard let dayDate = calendar.date(byAdding: .day, value: dayIndex, to: startOfWeek) else {
                continue
            }
            
            let startOfDay = calendar.startOfDay(for: dayDate)
            
            guard let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay) else {
                continue
            }
            
            let dayEntries = entries
                .filter { entry in
                    entry.createdAt >= startOfDay && entry.createdAt < endOfDay
                }
                .sorted { $0.createdAt < $1.createdAt }
            
            let totalAmount = dayEntries.reduce(0) { result, entry in
                result + Int(entry.amount)
            }
            
            let lastDailyGoal = Int(dayEntries.last?.dailyGoalAtMoment ?? 0)
            
            result.append(
                WeekWaterModel(
                    dayName: formatter.string(from: dayDate),
                    date: dayDate,
                    totalAmount: totalAmount,
                    dailyGoal: lastDailyGoal
                )
            )
        }
        
        return result
    }
}
