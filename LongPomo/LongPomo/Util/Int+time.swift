//
//  Int+time.swift
//  LongPomo
//
//  Created by Daniel Vela on 22/05/2017.
//  Copyright © 2017 Daniel Vela. All rights reserved.
//

import Foundation

extension Int {
    func minutes() -> Int {
        return self * 60
    }

    func toMMSS() -> String {
        let mm = self / 60
        let ss = self % 60
        return "\(mm):\(ss)"
    }
}

extension Double {
    func minutes() -> Double {
        return self * 60
    }

    func toMMSS() -> String {
        let sInt = Int(self)
        let mm = sInt / 60
        let ss = sInt % 60
        return String(format: "%02d:%02d", mm, ss)
    }

    func toMM() -> String {
        let sInt = Int(self)
        let mm = sInt / 60
        return String(format: "%02d", mm)
    }
}
