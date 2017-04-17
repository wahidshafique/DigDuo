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
    let gameState: GKStateMachine
    
    /* main init */
    init(scene: SKScene, sprite: SKSpriteNode, states: GKState ...) {
        self.scene = scene as! GameScene
        self.sprite = sprite
        self.scene.addChild(sprite)
        /* init the game state machine with the available states */
        self.gameState = GKStateMachine(states: states)
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /* ==============================================================
     GAME STATES [helpers, not needed unless externally called'
     ============================================================== */
    
    /* functions for changing between states */
    func movingFunc() {
        gameState.enter(MovingState.self)
        //TODO
    }
    
    func staticFunc() {
        gameState.enter(StaticState.self)
        //TODO
    }
}
