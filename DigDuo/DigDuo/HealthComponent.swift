//
//  HealthComponent.swift
//  DigDuo
//
//  Created by Tech on 2017-04-15.
//  Copyright © 2017 Talpa Studios. All rights reserved.
//
import SpriteKit
import GameplayKit

/*component to handle the health monitoring of the entity */

class HealthComponent: GKComponent {
    unowned let scene: GameScene
    let sprite: SKSpriteNode
    
    /*track health */
    let health: Double!
    
    /* main init */
    init(scene: SKScene, sprite: SKSpriteNode, health: Double) {
        self.scene = scene as! GameScene
        self.sprite = sprite
        self.health = health
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
