//
//  PlayerEntity.swift
//  DigDuo
//
//  Created by Tech on 2017-04-15.
//  Copyright © 2017 Talpa Studios. All rights reserved.
//

import GameplayKit

class PlayerEntity: GKEntity {
    
    var pos: CGPoint!
    
    var score = Scorer()
    
    /* main init */
    init(pos: CGPoint) {
        self.pos = pos
        super.init()
    }
    
    func notifyCollision(contact: SKPhysicsContact, selfBody: SKPhysicsBody, otherBody: SKPhysicsBody)
    {
        if canKill && otherBody.categoryBitMask == CollisionLayer.Enemy.rawValue
        {
            otherBody.node!.removeFromParent()
            canKill = false
            
            score.score += 1
            score.getSetAllScoresSorted()
        }
    }
    
    func getScore() -> Int
    {
        return score.score
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        if !canKill
        {
            timeSinceLastKill += seconds
            
            if (timeSinceLastKill > 1.0)
            {
                timeSinceLastKill = 0.0
                canKill = true
            }
        }
    }
    
    private var canKill: Bool = true
    
    private var timeSinceLastKill : TimeInterval = 0.0
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
