//
//  TimerCircleView.swift
//  LongPomo
//
//  Created by Daniel Vela on 23/05/2017.
//  Copyright © 2017 Daniel Vela. All rights reserved.
//

import Cocoa

class TimerCicleOval {

    var lineWidth: CGFloat?
    var path: CGPath?
    var strokeStart: CGFloat?
    var strokeEnd: CGFloat?
    var strokeColor: NSColor?
    var fillColor: NSColor?
    var shadowRadius: CGFloat?
    var shadowOpacity: Float?
    var shadowOffsset: CGSize?

    func ovalShapeLayer() -> CAShapeLayer {
        let arc = CAShapeLayer()
        arc.lineWidth = lineWidth!
        arc.path = path
        arc.strokeStart = strokeStart!
        arc.strokeEnd = strokeEnd!
        arc.strokeColor = strokeColor!.cgColor
        arc.fillColor = fillColor!.cgColor
        arc.shadowColor = NSColor.black.cgColor
        arc.shadowRadius = shadowRadius!
        arc.shadowOpacity = shadowOpacity!
        arc.shadowOffset = shadowOffsset!
        return arc
    }
}
class TimerCircleView: NSView {
    var primaryColor: NSColor = AppColors.primaryColor
    var secondaryColor: NSColor = AppColors.secondaryColor
    var arcRadious: CGFloat = 250
    var kLineWidth: CGFloat = 20

    func addOval(oval: TimerCicleOval) {
        let arc = oval.ovalShapeLayer()
        layer?.addSublayer(arc)
    }

    func ovalBottom(_ path: NSBezierPath, _ color: NSColor) -> TimerCicleOval {
        let ovalBottom = TimerCicleOval()
        ovalBottom.lineWidth = kLineWidth
        ovalBottom.path = path.CGPath
        ovalBottom.strokeStart = 0
        ovalBottom.strokeEnd = 1
        ovalBottom.strokeColor = color
        ovalBottom.fillColor = NSColor.clear
        ovalBottom.shadowRadius = 0
        ovalBottom.shadowOpacity = 0
        ovalBottom.shadowOffsset = CGSize.zero
        return ovalBottom
    }

    func ovalTop(_ path: NSBezierPath, _ color: NSColor) -> TimerCicleOval {
        let ovalTop = TimerCicleOval()
        ovalTop.lineWidth = kLineWidth
        ovalTop.path = path.CGPath
        ovalTop.strokeStart = 0
        ovalTop.strokeEnd = 1
        ovalTop.strokeColor = color
        ovalTop.fillColor = NSColor.clear
        ovalTop.shadowRadius = 0
        ovalTop.shadowOpacity = 0
        ovalTop.shadowOffsset = CGSize.zero
        return ovalTop
    }

    func addCirle(arcRadius: CGFloat, capRadius: CGFloat, colorTop: NSColor, colorBottom: NSColor) {
        let X = self.bounds.midX
        let Y = self.bounds.midY

        // Bottom Oval
        let pathBottom = NSBezierPath(ovalIn: NSRect(origin: CGPoint(x: X - (arcRadius/2),
                                                                     y: Y - (arcRadius/2)),
                                                     size: CGSize(width: arcRadius,
                                                                  height:arcRadius)))
        self.addOval(oval: ovalBottom(pathBottom, colorBottom))

        // Top Oval
        // Start 90  -> maxLeftSeconds
        // End -270  -> 0 leftSeconds
        // Dif -360 * (currentSec * maxLeftSeconds)
        let pathTop = NSBezierPath()
        pathTop.appendArc(withCenter: NSPoint(x: X, y: Y), radius: 125, startAngle: 90, endAngle: -260, clockwise: true)

        self.addOval(oval: ovalTop(pathTop, colorTop))
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
        self.addCirle(arcRadius: self.arcRadious,
                      capRadius: 20,
                      colorTop: self.primaryColor,
                      colorBottom:  self.secondaryColor)
    }
}
