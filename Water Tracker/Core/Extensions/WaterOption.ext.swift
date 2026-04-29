
import Foundation

extension WaterOption {
    static func waterOption(_ option:  String) -> WaterOption {
        return WaterOption(rawValue: option) ?? .small
    }
}
