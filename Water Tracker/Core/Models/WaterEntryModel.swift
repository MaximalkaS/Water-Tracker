
import Foundation

struct WaterEntryModel: Identifiable {
    let id: String
    let remaining: Int
    let amount: Int
    let dailyGoalAtMoment: Int
    let createdAt: Date
}
