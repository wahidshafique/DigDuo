//
//  IDigduoScene.swift
//  DigDuo
//
//  Created by Digduo Team on 2017-03-17.
//  Copyright © 2017 Talpa Studios. All rights reserved.
//

import SpriteKit
import GameKit

protocol IDigduoScene : class {
    func loadScene(scene: SKScene, transition: SKTransition)
    func toMainMenu(transition: SKTransition)
    func resetScene(transition: SKTransition)
    func shutdown()
}
