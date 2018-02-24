//
//  AppColors.swift
//  LongPomo
//
//  Created by Daniel Vela on 22/05/2017.
//  Copyright © 2017 Daniel Vela. All rights reserved.
//

let backgroundColorRed = 0.0
let backgroundColorGreen = 0.0
let backgroundColorBlue = 0.0
let backgroundColorAlpha = 0.0

let secondaryColorRed = 0.2
let secondaryColorGreen = 0.2
let secondaryColorBlue = 0.2
let secondaryColorAlpha = 1.0

let accentColorRed = 0.0
let accentColorGreen = 0.6
let accentColorBlue = 1.0
let accentColorAlpha = 1.0

let primaryColorRed = 1.0
let primaryColorGreen = 1.0
let primaryColorBlue = 0.0
let primaryColorAlpha = 1.0

#if os(macOS)
    import Cocoa
    typealias Color = NSColor
    class AppColors {
        static var backgroundColor = Color(calibratedRed: CGFloat(backgroundColorRed),
                                           green: CGFloat(backgroundColorGreen),
                                           blue: CGFloat(backgroundColorBlue),
                                           alpha: CGFloat(backgroundColorAlpha))
        static var secondaryColor = Color(calibratedRed: CGFloat(secondaryColorRed),
                                          green: CGFloat(secondaryColorGreen),
                                          blue: CGFloat(secondaryColorBlue),
                                          alpha: CGFloat(secondaryColorAlpha))
        static var accentColor = Color(calibratedRed: CGFloat(accentColorRed),
                                       green: CGFloat(accentColorGreen),
                                       blue: CGFloat(accentColorBlue),
                                       alpha: CGFloat(accentColorAlpha))
        static var primaryColor = Color(calibratedRed: CGFloat(primaryColorRed),
                                        green: CGFloat(primaryColorGreen),
                                        blue: CGFloat(primaryColorBlue),
                                        alpha: CGFloat(primaryColorAlpha))
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
