//
//  MoveComponent.swift
//  DigDuo
//
//  Created by Tech on 2017-04-15.
//  Copyright © 2017 Talpa Studios. All rights reserved.
//

import SpriteKit
import GameplayKit

/* a simple component to handle the movement of the entity */

class EnemyMoveComponent: GKComponent {
    
    /* main variables to hold a reference for the scene and sprite */
    unowned let scene: GameScene
    let sprite: SKSpriteNode
    unowned let enemy: EnemyEntity
    
    /* main init */
    init(scene: SKScene, sprite: SKSpriteNode, enemyEntity: EnemyEntity) {
        self.scene = scene as! GameScene
        self.sprite = sprite
        self.enemy = enemyEntity
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /* function to move sprite from point A to point B via touch */
    func moveToPoint(_ point: CGPoint, duration: TimeInterval) {
        sprite.rotateVersus(destPoint: point)
        let moveTo = SKAction.move(to: point, duration: duration)
        
        sprite.run(SKAction.sequence([moveTo, SKAction.run({ ()-> Void in
            self.enemy.stateMachine?.enter(IdleState.self)
        })])
        )}
}
