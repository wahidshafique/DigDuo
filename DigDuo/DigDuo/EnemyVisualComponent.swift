//
//  VisualComponent.swift
//  DigDuo
//
//  Created by Tech on 2017-04-15.
//  Copyright © 2017 Talpa Studios. All rights reserved.
//

import SpriteKit
import GameplayKit

/* a simple component to handle the visual representation of the entity */

class EnemyVisualComponent: GKComponent {
    unowned let scene: GameScene
    let sprite: SKSpriteNode
    unowned let enemyEntity: EnemyEntity
    
    /* main init */
    init(scene: SKScene, sprite: SKSpriteNode, enemyEntity: EnemyEntity) {
        self.scene = scene as! GameScene
        self.sprite = sprite
        self.enemyEntity = enemyEntity
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
