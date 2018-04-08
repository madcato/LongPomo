//
//  TimerCircleView.swift
//  LongPomo
//
//  Created by Daniel Vela on 23/05/2017.
//  Copyright © 2017 Daniel Vela. All rights reserved.
//

import UIKit

class TimerCicleOvalShadow {
    var shadowRadius: CGFloat
    var shadowOpacity: Float
    var shadowOffsset: CGSize

    init() {
        self.shadowRadius = 2
        self.shadowOpacity = 1
        self.shadowOffsset = CGSize.zero
    }

    func configureShapeLayer(layer: CAShapeLayer) -> CAShapeLayer {
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = shadowOffsset
        return layer
    }
}

class TimerCicleOvalLine {
    var lineWidth: CGFloat
    var strokeStart: CGFloat
    var strokeEnd: CGFloat
    var strokeColor: Color

    init(_ lineWidth: CGFloat, _ color: Color) {
        self.lineWidth = lineWidth
        self.strokeStart = 0
        self.strokeEnd = 1
        self.strokeColor = color
    }

    func configureShapeLayer(layer: CAShapeLayer) -> CAShapeLayer {
        layer.lineWidth = lineWidth
        layer.strokeStart = strokeStart
        layer.strokeEnd = strokeEnd
        layer.strokeColor = strokeColor.cgColor
        return layer
    }
}

class TimerCicleOval {
    var path: CGPath?
    var fillColor: UIColor?
    var shadow: TimerCicleOvalShadow?
    var line: TimerCicleOvalLine?

    func ovalShapeLayer() -> CAShapeLayer {
        var arc = CAShapeLayer()
        arc.path = path
        arc.fillColor = fillColor!.cgColor
        arc.shadowColor = UIColor.black.cgColor
        arc = (shadow?.configureShapeLayer(layer: arc))!
        arc = (line?.configureShapeLayer(layer: arc))!
        arc.lineCap = kCALineCapRound
        return arc
    }
}

class TimerCircleView: UIView {
    var primaryColor: UIColor = AppColors.primaryColor
    var secondaryColor: UIColor = AppColors.secondaryColor
    var arcRadious: CGFloat = 25
    var margin: CGFloat = 60
    var kLineWidth: CGFloat = 20

    var currentProgress: Double = 1.0 { // Valid values from 0.0 to 1.0
        didSet {
            if currentProgress > 1.0 {
                currentProgress = 1.0
            }
            if currentProgress < 0.0 {
                currentProgress = 0.0
            }
            redraw()
        }
    }

    var prevSublayer: [CALayer] = []

    func addOval(oval: TimerCicleOval) {
        let arc = oval.ovalShapeLayer()
        layer.addSublayer(arc)
        prevSublayer.append(arc)
    }

    func ovalBottom(_ path: UIBezierPath, _ color: Color) -> TimerCicleOval {
        let ovalBottom = TimerCicleOval()
        ovalBottom.path = path.cgPath
        ovalBottom.fillColor = Color.clear

        let ovalBottomShadow = TimerCicleOvalShadow()
        ovalBottom.shadow = ovalBottomShadow

        let ovalBottomLine = TimerCicleOvalLine(kLineWidth, color)
        ovalBottom.line = ovalBottomLine

        return ovalBottom
    }

    func ovalTop(_ path: UIBezierPath, _ color: Color) -> TimerCicleOval {
        let ovalTop = TimerCicleOval()
        ovalTop.path = path.cgPath
        ovalTop.fillColor = Color.clear

        let ovalTopShadow = TimerCicleOvalShadow()
        ovalTop.shadow = ovalTopShadow

        let ovalTopLine = TimerCicleOvalLine(kLineWidth, color)
        ovalTop.line = ovalTopLine

        return ovalTop
    }

    func addCirle(arcRadius: CGFloat, colorTop: Color, colorBottom: Color) {
        let vslX = self.bounds.midX
        let vslY = self.bounds.midY

        // Bottom Oval
        let pathBottom = UIBezierPath(ovalIn: CGRect(origin: CGPoint(x: vslX - (arcRadius/2),
                                                                     y: vslY - (arcRadius/2)),
                                                     size: CGSize(width: arcRadius,
                                                                  height: arcRadius)))
        self.addOval(oval: ovalBottom(pathBottom, colorBottom))

        // Top Oval
        // Start - PI/2  -> maxLeftSeconds
        // End +3PI/2  -> 0 leftSeconds
        // Dif 2PI * (currentSec * maxLeftSeconds)
        let pathTop = UIBezierPath.init(arcCenter: CGPoint(x: vslX, y: vslY),
                                        radius: arcRadius/2,
                                        startAngle: CGFloat(-Double.pi/2),
                                        endAngle: calculateEndAngle(),
                                        clockwise: true)
        pathTop.lineCapStyle = .round

        self.addOval(oval: ovalTop(pathTop, colorTop))
    }

    func removePrevSublayer() {
        for subl in prevSublayer {
            subl.removeFromSuperlayer()
        }
        prevSublayer.removeAll()
    }

    override func draw(_ rect: CGRect) {
        removePrevSublayer()
        // Drawing code here.
        self.arcRadious = self.bounds.height - margin
        self.addCirle(arcRadius: self.arcRadious,
                      colorTop: self.primaryColor,
                      colorBottom: self.secondaryColor)
    }

    func redraw() {
        // invalidate view
        self.setNeedsDisplay()
    }

    func calculateEndAngle() -> CGFloat {
        return CGFloat((Double.pi * 2 * (1-currentProgress)) - (Double.pi / 2))
    }
}
