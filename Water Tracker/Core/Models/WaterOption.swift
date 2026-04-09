
import Foundation

enum WaterOption: String, CaseIterable, Identifiable {
    case small
    case medium
    case large
    
    var id: String { rawValue }
    
    var image: String {
        switch self {
        case .small:
            return "smallDrinkImage"
        case .medium:
            return "mediumDrinkImage"
        case .large:
            return "largeDrinkImage"
        }
    }
    
    var title: String {
        switch self {
        case .small:
            return "Small"
        case .medium:
            return "Medium"
        case .large:
            return "Large"
        }
    }
}
