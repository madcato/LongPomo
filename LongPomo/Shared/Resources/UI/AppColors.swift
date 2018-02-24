//
//  AppColors.swift
//  LongPomo
//
//  Created by Daniel Vela on 22/05/2017.
//  Copyright © 2017 Daniel Vela. All rights reserved.
//

import UIKit

let backgroundColorRed: CGFloat = 0.0
let backgroundColorGreen: CGFloat = 0.0
let backgroundColorBlue: CGFloat = 0.0
let backgroundColorAlpha: CGFloat = 0.0

let secondaryColorRed: CGFloat = 0.2
let secondaryColorGreen: CGFloat = 0.2
let secondaryColorBlue: CGFloat = 0.2
let secondaryColorAlpha: CGFloat = 1.0

let accentColorRed: CGFloat = 0.0
let accentColorGreen: CGFloat = 0.6
let accentColorBlue: CGFloat = 1.0
let accentColorAlpha: CGFloat = 1.0

let primaryColorRed: CGFloat = 1.0
let primaryColorGreen: CGFloat = 1.0
let primaryColorBlue: CGFloat = 0.0
let primaryColorAlpha: CGFloat = 1.0

#if os(macOS)
    import Cocoa
    typealias Color = NSColor
    class AppColors {
        static var backgroundColor = Color(calibratedRed: backgroundColorRed,
                                           green: backgroundColorGreen,
                                           blue: backgroundColorBlue,
                                           alpha: backgroundColorAlpha)
        static var secondaryColor = Color(calibratedRed: secondaryColorRed,
                                          green: secondaryColorGreen,
                                          blue: secondaryColorBlue,
                                          alpha: secondaryColorAlpha)
        static var accentColor = Color(calibratedRed: accentColorRed,
                                       green: accentColorGreen,
                                       blue: accentColorBlue,
                                       alpha: accentColorAlpha)
        static var primaryColor = Color(calibratedRed: primaryColorRed,
                                        green: primaryColorGreen,
                                        blue: primaryColorBlue,
                                        alpha: primaryColorAlpha)
    }
#endif

#if os(iOS)
    import UIKit
    typealias Color = UIColor
    class AppColors {
        static var backgroundColor = Color(red: backgroundColorRed,
                                           green: backgroundColorGreen,
                                           blue: backgroundColorBlue,
                                           alpha: backgroundColorAlpha)
        static var secondaryColor = Color(red: secondaryColorRed,
                                          green: secondaryColorGreen,
                                          blue: secondaryColorBlue,
                                          alpha: secondaryColorAlpha)
        static var accentColor = Color(red: accentColorRed,
                                       green: accentColorGreen,
                                       blue: accentColorBlue,
                                       alpha: accentColorAlpha)
        static var primaryColor = Color(red: primaryColorRed,
                                        green: primaryColorGreen,
                                        blue: primaryColorBlue,
                                        alpha: primaryColorAlpha)
    }
#endif
