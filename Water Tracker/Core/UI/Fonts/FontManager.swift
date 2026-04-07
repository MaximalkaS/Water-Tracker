
import SwiftUI

enum PoppinsFontName: String {
    case light = "Poppins-Light"
    case regular = "Poppins-Regular"
    case medium = "Poppins-Medium"
    case bold = "Poppins-Bold"
    case semibold = "Poppins-SemiBold"
}


extension Font {
    static let headlinePrimary = Font.custom(PoppinsFontName.bold.rawValue, size: 24)
    static let headlineSub = Font.custom(PoppinsFontName.light.rawValue, size: 14)
    static let headlineSecondary = Font.custom(PoppinsFontName.medium.rawValue, size: 16)
    
    static let statValue = Font.custom(PoppinsFontName.medium.rawValue, size: 24)

    static let bodyRegular = Font.custom(PoppinsFontName.regular.rawValue, size: 14)
    static let bodyCaption = Font.custom(PoppinsFontName.regular.rawValue, size: 11)
    
    static let weekdayLabel = Font.custom(PoppinsFontName.regular.rawValue, size: 10)

    static let buttonLabel = Font.custom(PoppinsFontName.medium.rawValue, size: 14)
}
