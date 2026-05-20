import Foundation

struct WeekWaterModel: Identifiable {
    let id = UUID()
    let dayName: String
    let date: Date
    let totalAmount: Int
    let dailyGoal: Int
}
