//
//  NSBezierPath+CGPath.swift
//  LongPomo
//
//  Created by Daniel Vela on 23/05/2017.
//  Copyright © 2017 Daniel Vela. All rights reserved.
//

import AppKit

public extension NSBezierPath {

    public var CGPath: CGPath {
        let path = CGMutablePath()
        var points = [CGPoint](repeating: .zero, count: 3)
        for indexI in 0 ..< self.elementCount {
            let type = self.element(at: indexI, associatedPoints: &points)
            switch type {
            case .moveToBezierPathElement: path.move(to: points[0])
            case .lineToBezierPathElement: path.addLine(to: points[0])
            case .curveToBezierPathElement: path.addCurve(to: points[2], control1: points[0], control2: points[1])
            case .closePathBezierPathElement: path.closeSubpath()
            }
        }
        return path
    }
}
