
import Foundation

protocol WaterStorageProtocol: AnyObject {
    func getAmount(for option: WaterOption) -> Int
    func setAmount(_ amount: Int, for option: WaterOption)
    var dailyIntake: Int { get set }
    var dailyGoal: Int { get set }
}

class WaterStorage: WaterStorageProtocol {
    private let defaults = UserDefaults.standard
    
    private enum Keys {
        static let small = "waterSmall"
        static let medium = "waterMedium"
        static let large = "waterLarge"
        
        static let dailyIntake = "waterDailyIntake"
        static let dailyGoal = "waterDailyGoal"
        
        static let lastUpdatedAt = "waterLastUpdatedAt"
    }
    
    func getAmount(for option: WaterOption) -> Int {
        let key = key(for: option)
        let value = defaults.integer(forKey: key)
        
        return value == 0 ? defaultAmount(for: option) : value
    }
    
    func setAmount(_ amount: Int, for option: WaterOption) {
        let key = key(for: option)
        defaults.set(amount, forKey: key)
    }
    
    var dailyIntake: Int {
        get {
            resetIfNeeded()
            return defaults.integer(forKey: Keys.dailyIntake)
        }
        set {
            resetIfNeeded()
            defaults.set(newValue, forKey: Keys.dailyIntake)
        }
    }
    
    var dailyGoal: Int {
        get {
            let value = defaults.integer(forKey: Keys.dailyGoal)
            return value == 0 ? 2000 : value
        }
        set {
            defaults.set(newValue, forKey: Keys.dailyGoal)
        }
    }
    
    func resetIfNeeded() {
        let calendar = Calendar.current
        let now = Date()
        let lastUpdatedAt = defaults.object(forKey: Keys.lastUpdatedAt) as? Date ?? now
        
        if !calendar.isDate(lastUpdatedAt, inSameDayAs: now) {
            defaults.set(0, forKey: Keys.dailyIntake)
            defaults.set(now, forKey: Keys.lastUpdatedAt)
        }
    }
    
    private func key(for option: WaterOption) -> String {
        switch option {
        case .small:
            return Keys.small
        case .medium:
            return Keys.medium
        case .large:
            return Keys.large
        }
    }
    
    private func defaultAmount(for option: WaterOption) -> Int {
        switch option {
        case .small:
            return 100
        case .medium:
            return 250
        case .large:
            return 500
        }
    }
}

