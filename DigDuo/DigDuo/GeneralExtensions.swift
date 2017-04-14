//
//  GeneralExtensions.swift
//  DigDuo
//
//  Created by Digduo Team on 2017-03-17.
//  Copyright © 2017 Talpa Studios. All rights reserved.
//

import SpriteKit
import GameKit

// defines
typealias Fraction = CTuple

func sync(lock: NSObject, closure: () -> Void) {
    objc_sync_enter(lock)
    closure()
    objc_sync_exit(lock)
}

extension SKNode {
    func rotateVersus(destPoint: CGPoint) {
        let v1 = CGVector(dx:0, dy:1)
        let v2 = CGVector(dx:destPoint.x - position.x, dy: destPoint.y - position.y)
        let angle = atan2(v2.dy, v2.dx) - atan2(v1.dy, v1.dx)
        zRotation = angle
    }
}

extension CGVector {
    static func *(_ lhs: CGVector, _ scalarValue: CGFloat) -> CGVector {
        return CGVector(dx: lhs.dx*scalarValue, dy: lhs.dy*scalarValue)
    }

    static func -(_ lhs: CGVector, _ rhs: CGVector) -> CGVector {
        var resultVec: CGVector = lhs

        resultVec.dx -= rhs.dx
        resultVec.dy -= rhs.dy

        return resultVec
    }

    static func +(_ lhs: CGVector, _ rhs: CGVector) -> CGVector {
        var resultVec: CGVector = lhs

        resultVec.dx += rhs.dx
        resultVec.dy += rhs.dy

        return resultVec
    }

    static func /(_ lhs: CGVector, _ rhs: CGFloat) -> CGVector {
        var resultVec: CGVector = lhs

        resultVec.dx /= rhs

        return resultVec
    }

    static func -=(_ lhs: inout CGVector, _ rhs: CGVector) {
        lhs.dx -= rhs.dx
        lhs.dy -= rhs.dy
    }

    static func +=(_ lhs: inout CGVector, _ rhs: CGVector) {
        lhs.dx += rhs.dx
        lhs.dy += rhs.dy
    }

    static func *=(_ lhs: inout CGVector, _ rhs: CGFloat) {
        lhs.dx *= rhs
        lhs.dy *= rhs
    }

    static func /=(_ lhs: inout CGVector, _ rhs: CGFloat) {
        lhs.dx /= rhs
        lhs.dy /= rhs
    }

    mutating func normalize() {
        self.dx /= magnitude
        self.dy /= magnitude
    }

    var magnitude: CGFloat {
        return CGFloat(sqrt(self.dx*self.dx + self.dy*self.dy))
    }

    var normalized: CGVector {
        return CGVector(dx: self.dx/magnitude, dy: self.dy/magnitude)
    }
}

extension CGPoint {
    static func +=(_ lhs: inout CGPoint, _ rhs: CGVector) {
        lhs.x += rhs.dx
        lhs.y += rhs.dy
    }

    static func -=(_ lhs: inout CGPoint, _ rhs: CGVector) {
        lhs.x -= rhs.dx
        lhs.y -= rhs.dy
    }

    static func +(_ lhs: inout CGPoint, _ rhs: CGVector) -> CGPoint {
        let resultPointX = lhs.x + rhs.dx
        let resultPointY = lhs.y + rhs.dy

        return CGPoint(x: resultPointX, y: resultPointY)
    }

    static func -(_ lhs: CGPoint, _ rhs: CGVector) -> CGPoint {
        let resultPointX = lhs.x - rhs.dx
        let resultPointY = lhs.y - rhs.dy

        return CGPoint(x: resultPointX, y: resultPointY)
    }

    static func -(_ lhs: CGPoint, _ rhs: CGPoint) -> CGVector {
        return CGVector(dx: lhs.x - rhs.x, dy: lhs.y - rhs.y)
    }
}

extension SKScene {
    func getDimensionsInWorldUnits(ppu: (CGFloat, CGFloat)) -> CGSize {
        let screenWidth = size.width
        let screenHeight = size.height

        return CGSize(width: screenWidth/ppu.0, height: screenHeight/ppu.1)
    }
    
    func getDimensionsInScreen() -> CGSize {
        return size
    }
}

extension CGSize {
    public func getRatio() -> (CGFloat, CGFloat) {
        if width == height {
            return (1.0, 1.0)
        }

        let gcd: CGFloat = CGFloat(GCD(Fraction(a: Int32(width), b: Int32(height))))
        let ratioWidth: CGFloat = width/gcd
        let ratioHeight: CGFloat = height/gcd

        return (ratioWidth, ratioHeight)
    }
}

extension SKView {
    var screenWidth: CGFloat {
        return frame.size.width
    }

    var screenHeight: CGFloat {
        return frame.size.height
    }

    var screenRatio: (CGFloat, CGFloat) {
        return frame.size.getRatio()
    }
}
