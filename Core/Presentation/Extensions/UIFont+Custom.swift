//
//  Created by Karina Lipnyagova on 22.04.2021
//  Copyright © Pavel Lipnyagov & Karina Lipnyagova. All rights reserved.

import UIKit

extension UIFont {
    private enum Constants {
        enum FontName {
            static let regular: String = "SFProDisplay-Regular"
            static let medium: String = "SFProDisplay-Medium"
            static let bold: String = "SFProDisplay-Bold"
        }
        
        enum FontSize {
            static let small: CGFloat = 12
            static let normal: CGFloat = 16
            static let large: CGFloat = 18
            static let extraLarge: CGFloat = 24
        }
    }
    
    // MARK: - Small font
    
    class var smallRegular: UIFont {
        get {
            return UIFont(name: Constants.FontName.regular, size: Constants.FontSize.small)!
        }
    }
    
    class var smallMedium: UIFont {
        get {
            return UIFont(name: Constants.FontName.medium, size: Constants.FontSize.small)!
        }
    }
    
    // MARK: - Normal font
    
    class var normalRegular: UIFont {
        get {
            return UIFont(name: Constants.FontName.regular, size: Constants.FontSize.normal)!
        }
    }
    
    class var normalMedium: UIFont {
        get {
            return UIFont(name: Constants.FontName.medium, size: Constants.FontSize.normal)!
        }
    }
    
    class var normalBold: UIFont {
        get {
            return UIFont(name: Constants.FontName.bold, size: Constants.FontSize.normal)!
        }
    }
    
    // MARK: - Large font
    
    class var largeRegular: UIFont {
        get {
            return UIFont(name: Constants.FontName.regular, size: Constants.FontSize.large)!
        }
    }
    
    class var largeMedium: UIFont {
        get {
            return UIFont(name: Constants.FontName.medium, size: Constants.FontSize.large)!
        }
    }
    
    class var largeBold: UIFont {
        get {
            return UIFont(name: Constants.FontName.bold, size: Constants.FontSize.large)!
        }
    }
    
    // MARK: - Extra large font
    
    class var extraLargeBold: UIFont {
        get {
            return UIFont(name: Constants.FontName.bold, size: Constants.FontSize.extraLarge)!
        }
    }
}
