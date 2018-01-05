//
//  ANColors.swift
//  slideshow
//
//  Created by Cory Santiago on 6/30/15.
//  Copyright (c) 2015 Animoto. All rights reserved.
//

import UIKit

// swiftlint:disable identifier_name
fileprivate func RGBA(_ r: Float, g: Float, b: Float, a: Float = 1 ) -> UIColor { return UIColor(red: CGFloat(r / 255.0), green: CGFloat(g / 255.0), blue: CGFloat(b / 255.0), alpha: CGFloat(a)) }
// swiftlint:enable identifier_name

@objc extension UIColor {

    class func ANDarkGray() -> UIColor {
        return RGBA(80, g: 80, b: 80)
    }
    
    class func ANMediumGray() -> UIColor {
        return RGBA(150, g: 150, b: 150)
    }
    
    class func ANLightGray() -> UIColor {
        return RGBA(238, g: 238, b: 238)
    }
    
    class func ANGray() -> UIColor {
        return RGBA(218, g: 218, b: 218)
    }
    
    class func ANWhite() -> UIColor {
        return RGBA(255, g: 255, b: 255)
    }
    
    class func ANBlack() -> UIColor {
        return RGBA(40, g: 40, b: 40)
    }
    
    class func ANGreen() -> UIColor {
        return RGBA(51, g: 190, b: 123)
    }
    
    class func ANLightTeal() -> UIColor {
        return RGBA(179, g: 224, b: 224)
    }
    
    class func ANTeal() -> UIColor {
        return RGBA(27, g: 205, b: 207)
    }
    
    class func ANDarkTeal() -> UIColor {
        return RGBA(0, g: 140, b: 149)
    }
    
    class func ANCyanAccent() -> UIColor {
        return RGBA(21, g: 157, b: 159)
    }
    
    class func ANOrange() -> UIColor {
        return RGBA(238, g: 166, b: 53)
    }
    
    class func ANFacebookBlue() -> UIColor {
        return RGBA(59, g: 89, b: 152)
    }
    
    class func ANFacebookBlueHighlighted() -> UIColor {
        return RGBA(34, g: 153, b: 232)
    }
    
    class func ANRed() -> UIColor {
        return RGBA(235, g: 93, b: 82)
    }
    
    class func ANRedAccent() -> UIColor {
        return RGBA(184, g: 80, b: 71)
    }
    
    class func ANLime() -> UIColor {
        return RGBA(147, g: 201, b: 14)
    }
    
    // Explicit methods
    class func primaryBackgroundColor() -> UIColor {
        return white
    }
    
    static let secondaryBackgroundColor: UIColor = ANLightGray()
    
    class func gridBackgroundColor() -> UIColor {
        return white
    }
    
    class func videoClipTableBackground() -> UIColor {
        return ANWhite()
    }
    
    class func mediumGrayTextColor() -> UIColor {
        return ANBlack()
    }
    
    class func lightGrayTextColor() -> UIColor {
        return ANMediumGray()
    }
    
    class func textFieldInactiveColor() -> UIColor {
        return ANMediumGray()
    }
    
    class func textFieldActiveColor() -> UIColor {
        return ANTeal()
    }
    
    class func textFieldErrorColor() -> UIColor {
        return ANRed()
    }
    
    // MARK: - Header Label
    static let headerLabelColor: UIColor = ANDarkGray()
    static let headerKeylineColor: UIColor = ANTeal()
    
    // MARK: - Buttons
    static let buttonInactiveColor: UIColor = ANMediumGray()
    static let buttonActiveColor: UIColor = ANTeal()
    static let buttonHighlightedColor: UIColor = ANDarkTeal()
    
    // MARK: - Label
    static let primaryLabelTextColor: UIColor = black
    static let primaryLabelHighlightedTextColor: UIColor = ANMediumGray()
    static let secondaryLabelTextColor: UIColor = ANMediumGray()
    
    // MARK: - Cells
    static let cellBorderColor: UIColor = ANGray()
    static let cellBorderSelectedColor: UIColor = ANTeal()
    static let highlightedCellColor: UIColor = ANGray()
}
