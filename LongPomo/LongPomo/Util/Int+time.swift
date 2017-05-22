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
