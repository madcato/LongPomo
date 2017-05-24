//
//  TimerCircleView.swift
//  LongPomo
//
//  Created by Daniel Vela on 23/05/2017.
//  Copyright © 2017 Daniel Vela. All rights reserved.
//

import Cocoa

class TimerCicleOvalShadow {
    var shadowRadius: CGFloat?
    var shadowOpacity: Float?
    var shadowOffsset: CGSize?

    func configureShapeLayer(layer: CAShapeLayer) -> CAShapeLayer {
        layer.shadowRadius = shadowRadius!
        layer.shadowOpacity = shadowOpacity!
        layer.shadowOffset = shadowOffsset!
        return layer
    }
}

class TimerCicleOvalLine {
    var lineWidth: CGFloat?
    var strokeStart: CGFloat?
    var strokeEnd: CGFloat?
    var strokeColor: NSColor?

    func configureShapeLayer(layer: CAShapeLayer) -> CAShapeLayer {
        layer.lineWidth = lineWidth!
        layer.strokeStart = strokeStart!
        layer.strokeEnd = strokeEnd!
        layer.strokeColor = strokeColor!.cgColor
        return layer
    }
}

class TimerCicleOval {
    var path: CGPath?
    var fillColor: NSColor?
    var shadow: TimerCicleOvalShadow?
    var line: TimerCicleOvalLine?

    func ovalShapeLayer() -> CAShapeLayer {
        var arc = CAShapeLayer()
        arc.path = path
        arc.fillColor = fillColor!.cgColor
        arc.shadowColor = NSColor.black.cgColor
        arc = (shadow?.configureShapeLayer(layer: arc))!
        arc = (line?.configureShapeLayer(layer: arc))!
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
        ovalBottom.path = path.CGPath
        ovalBottom.fillColor = NSColor.clear

        let ovalBottomShadow = TimerCicleOvalShadow()
        ovalBottomShadow.shadowRadius = 0
        ovalBottomShadow.shadowOpacity = 0
        ovalBottomShadow.shadowOffsset = CGSize.zero
        ovalBottom.shadow = ovalBottomShadow

        let ovalBottomLine = TimerCicleOvalLine()
        ovalBottomLine.lineWidth = kLineWidth
        ovalBottomLine.strokeStart = 0
        ovalBottomLine.strokeEnd = 1
        ovalBottomLine.strokeColor = color
        ovalBottom.line = ovalBottomLine

        return ovalBottom
    }

    func ovalTop(_ path: NSBezierPath, _ color: NSColor) -> TimerCicleOval {
        let ovalTop = TimerCicleOval()
        ovalTop.path = path.CGPath
        ovalTop.fillColor = NSColor.clear

        let ovalTopShadow = TimerCicleOvalShadow()
        ovalTopShadow.shadowRadius = 0
        ovalTopShadow.shadowOpacity = 0
        ovalTopShadow.shadowOffsset = CGSize.zero
        ovalTop.shadow = ovalTopShadow

        let ovalTopLine = TimerCicleOvalLine()
        ovalTopLine.lineWidth = kLineWidth
        ovalTopLine.strokeStart = 0
        ovalTopLine.strokeEnd = 1
        ovalTopLine.strokeColor = color
        ovalTop.line = ovalTopLine

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
