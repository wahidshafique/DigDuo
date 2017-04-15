//
//  Player.swift
//  DigDuo
//
//  Created by Tech on 2017-04-14.
//  Copyright © 2017 Talpa Studios. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

enum EnemyState
{
    case None
    case Wander
    case Seek
    case Steal
    case Flee
}

class Enemy: SKNode, Animatable{
    
    override init () {
        let texture = SKTexture(imageNamed: "Girl_Snake_Pixel")
        sprite = SKSpriteNode(texture: texture, color: .white, size: .init(width: 128.0, height: 128.0))
        
        super.init()
        
        addChild(sprite)
        
        initializeActions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(deltaTime: CGFloat)
    {
        if (currentEnemyState == .Wander)
        {
            wander(deltaTime: deltaTime)
        }
    }
    
    private func wander(deltaTime: CGFloat)
    {
        if (currentEnemyState == .Wander)
        {
            if (targetPoint == nil)
            {
                targetPoint = GetRandomPoint(maxDistance: wanderRadius)
            }
            
            var dir = targetPoint! - position
            let distance = (dir).magnitude
            
            dir.normalize()
            
            if (distance <= reachTargetRadius)
            {
                targetPoint = nil
            }
            else
            {
                self.position += dir * wanderSpeed * deltaTime
            }
            
            if (self.action(forKey: "movement") == nil)
            {
                removeAllActions()
                self.run(actions["movement"]!, withKey: "movement")
            }
        }
    }
    
    private func initializeActions()
    {
        let movementAction = SKAction.repeatForever(
            .sequence([.rotate(toAngle: self.rotateAngle, duration: TimeInterval(1.0/self.wanderSpeed/CGFloat(2.0)), shortestUnitArc: true),
           .rotate(toAngle: -self.rotateAngle, duration: TimeInterval(1.0/self.wanderSpeed/CGFloat(2.0)), shortestUnitArc: true)])
        
        )
        
        actions["movement"] = movementAction
    }
    
    private func GetRandomPoint(maxDistance: CGFloat) -> CGPoint
    {
        // pick random direction
        
        var randXDir = Int32(arc4random_uniform(UInt32(maxDistance)))
        var randYDir = Int32(arc4random_uniform(UInt32(maxDistance)))
        
        if Float(randXDir) < (Float(maxDistance) / 2.0)
        {
            randXDir *= -1
        }
        if Float(randYDir) < (Float(maxDistance) / 2.0)
        {
            randYDir *= -1
        }
        
        var randDir = CGVector.init(dx: CGFloat(randXDir), dy: CGFloat(randYDir))
        randDir.normalize()
        
        let xLoc = self.position.x + (maxDistance*CGFloat(randDir.dx))
        let yLoc = self.position.y + (maxDistance*CGFloat(randDir.dy))
        
        return CGPoint(x: xLoc, y: yLoc)
    }
    
    func animationComplete(animationName: String) {
        print("anim complete")
    }
    
    public var sprite : SKSpriteNode
    weak var player : Player?
    private var actions = [String : SKAction]()
    private var currentEnemyState = EnemyState.Wander
    
    // ai properties
    private let wanderRadius: CGFloat = 75.0
    private let wanderSpeed: CGFloat = 13.0
    private let wanderGap: CGFloat = 3.0
    
    private let reachTargetRadius: CGFloat = 4.0
    
    private var targetPoint: CGPoint?
    private let rotateAngle: CGFloat = 45.0
}
