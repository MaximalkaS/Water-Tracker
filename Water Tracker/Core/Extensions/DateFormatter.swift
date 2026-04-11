
import Foundation

extension Date {
    func formatted() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d"
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: self)
    }
}
