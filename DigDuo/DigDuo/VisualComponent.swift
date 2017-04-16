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

class VisualComponent: GKComponent {
    unowned let scene: GameScene
    let sprite: SKSpriteNode
    
    /* a variable for the state machine, if needed */
    //let gameState: GKStateMachine
    
    /* main init */
    init(scene: SKScene, sprite: SKSpriteNode) {
        self.scene = scene as! GameScene
        self.sprite = sprite
        
        /* init the game state machine with the available states */
//        self.gameState = GKStateMachine(states:[ EnemyInRange(scene: scene, sprite: sprite),
//                                                 EnemyIsSafe(scene: scene, sprite: sprite) ])
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /* ==============================================================
     GAME STATES
     ============================================================== */
    
    /* functions for changing between states */
    func targetInRange() {
        //TODO
    }
    
    func tagetOutOfRange() {
        //TODO
    }
}
