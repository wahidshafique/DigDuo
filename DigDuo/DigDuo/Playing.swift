//
//  Playing.swift
//  DigDuo
//
//  Created by Tech on 2017-04-17.
//  Copyright © 2017 Talpa Studios. All rights reserved.
//

import SpriteKit
import GameplayKit

class Playing: GKState {
    unowned let scene: GameScene
    
    init(scene: SKScene) {
        self.scene = scene as! GameScene
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {
        if previousState is WaitForTap {
            print ("prev state from waiting for tap")
        }
    }
    
    override func update(deltaTime seconds: TimeInterval) {
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is GameOver.Type
    }
    
    func randomDirection() -> CGFloat {
        let speedFactor: CGFloat = 3.0
        return speedFactor
    }
    
    
}

