//
//  Int+time.swift
//  LongPomo
//
//  Created by Daniel Vela on 22/05/2017.
//  Copyright © 2017 Daniel Vela. All rights reserved.
//

import Foundation

/**
 Int class extension to make integer conversions
*/
extension Int {
    /**
     Transform the integer value into seconds, assuming the value are minutes.
     - Returns: The number multiplied by 60
    */
    func minutes() -> Int {
        return self * 60
    }

    /**
     Helper to write the number in seconds in a string format
     - Returns: The number of seconds transformed in format "mm:ss"
    */
    func toMMSS() -> String {
        let mmm = self / 60
        let sss = self % 60
        return "\(mmm):\(sss)"
    }
}

/**
 Double class extension to make conversions
*/
extension Double {
    /**
     Transform the double value into seconds, assuming the value are minutes.
     - Returns: The number multiplied by 60
    */
    func minutes() -> Double {
        return self * 60
    }

    /**
     Helper to write the number in seconds in a string format
     - Returns: The number of seconds transformed in format "mm:ss"
    */
    func toMMSS() -> String {
        let sInt = Int(self)
        let mmm = sInt / 60
        let sss = sInt % 60
        return String(format: "%02d:%02d", mmm, sss)
    }

    /**
     Helper to write the number in seconds in a string format
     - Returns: The number of seconds transformed in format "mm", showing minutes
     */
    func toMM() -> String {
        let sInt = Int(self)
        let mmm = sInt / 60
        return String(format: "%02d", mmm)
    }
}
