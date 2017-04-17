//
//  WanderState.swift
//  DigDuo
//
//  Created by Derek Mallory on 2017-04-16.
//  Copyright © 2017 Talpa Studios. All rights reserved.
//

import GameplayKit

class SeekState: GKState
{
    init(enemyEntity: EnemyEntity, wanderRadius: CGFloat, wanderSpeed: CGFloat)
    {
        self.enemyEntity = enemyEntity
        
        self.wanderRadius = wanderRadius
        self.wanderSpeed = wanderSpeed
        
        super.init()
    }
    
    override func didEnter(from previousState: GKState?)
    {
        SetRandomPoint()
    }
    
    private func SetRandomPoint()
    {
        let movementComp = enemyEntity.component(ofType: MoveComponent.self)
        if movementComp == nil
        {
            currentTarget = nil
            return
        }
        
        let node = movementComp!.sprite
        
        // pick random direction
        var randXDir = Int32(arc4random_uniform(UInt32(INT_MAX)))
        var randYDir = Int32(arc4random_uniform(UInt32(INT_MAX)))
        
        if Float(randXDir) < (Float(INT_MAX) / 2.0)
        {
            randXDir *= -1
        }
        if Float(randYDir) < (Float(INT_MAX) / 2.0)
        {
            randYDir *= -1
        }
        
        var randDir = CGVector.init(dx: CGFloat(randXDir), dy: CGFloat(randYDir))
        randDir.normalize()
        
        let xLoc = node.position.x + (wanderRadius*CGFloat(randDir.dx))
        let yLoc = node.position.y + (wanderRadius*CGFloat(randDir.dy))
        
        currentTarget = CGPoint.init(x: xLoc, y: yLoc)
        
        pointSet = true
    }
    
    override func willExit(to nextState: GKState)
    {
        pointSet = false
        currentTarget = nil
    }
    
    var wanderRadius: CGFloat
    var wanderSpeed: CGFloat
    
    private var enemyEntity: EnemyEntity
    private var pointSet: Bool = false
    
    var PointIsSet: Bool {
        return pointSet
    }
    
    var currentTarget: CGPoint?
}
