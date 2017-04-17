//
//  Gameover.swift
//  DigDuo
//
//  Created by Tech on 2017-04-17.
//  Copyright © 2017 Talpa Studios. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameOver: GKState {
    unowned let scene: GameScene
    
    init(scene: SKScene) {
        self.scene = scene as! GameScene
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {
        if previousState is Playing {
            print("prev state was playing")
        }
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is WaitForTap.Type
    }
    
}
