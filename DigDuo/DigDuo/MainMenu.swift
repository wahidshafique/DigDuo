//
//  MainMenu.swift
//  DigDuo
//
//  Created by Digduo Team on 2017-03-17.
//  Copyright © 2017 Talpa Studios. All rights reserved.
//

import SpriteKit
import GameplayKit

class MainMenu: SKScene {
    private var ui : UserInterface?
    private var uiElementNames = [String]()
    private var background: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        let dimensions = getDimensionsInScreen()
        ui = UserInterface(size: CGSize(width: dimensions.width, height: dimensions.height))
        
        background = SKSpriteNode(texture: SKTexture(imageNamed: "Background"), color: .white, size: dimensions)
        background?.blendMode = .replace
        background?.zPosition = 0
        background?.colorBlendFactor = 1.0
        addChild(background!)
        background!.position += CGVector(dx: dimensions.width/2.0, dy: dimensions.height/2.0)
        
        addChild(ui!)
        
        let menuText = ui?.AddText(name: "txt-title", text: "DIGDUO!", uiPos: CGPoint(x: 50, y: 60), fontColor: .yellow, size: 72.0)
        
        let atlas = SKTextureAtlas(named: "UIButtons")
        let textureButton = atlas.textureNamed("blue_button05")
        
        
        let startButton = ui?.AddButton(name: "btn-start", tex: textureButton, text: "START", uiPos: CGPoint(x: 50, y: 40), fontColor: .black, size: CGSize(width: 200, height: 100), closure: {
            self.loadScene(scene: GameScene.init(), transition: SKTransition.crossFade(withDuration: 0.25))
        })
        let leaderboardButton = ui?.AddButton(name: "btn-leaderboard", tex: textureButton, text: "LEADERBOARD", uiPos: CGPoint(x: 50, y: 25), fontColor: .black, size: CGSize(width: 200, height: 100), closure: {
            self.loadScene(scene: Leaderboard.init(), transition: SKTransition.crossFade(withDuration: 0.25))
        })
        
        // storing these keys in case we need to access them later through the ui
        if let title = menuText{
            uiElementNames.append(title)
        }
        if let start = startButton {
            uiElementNames.append(start)
        }
        if let leaderboard = leaderboardButton {
            uiElementNames.append(leaderboard)
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        // sends touch to ui elements
        ui!.onTouchDown(point: pos)
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        // TODO: notify ui
        // TODO: notify game
    }
    
    func touchUp(atPoint pos : CGPoint) {
        ui!.onTouchUp(point: pos)
        // TODO: notify ui
        // TODO: notify game
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func loadScene(scene: SKScene, transition: SKTransition)
    {
        if let skView = view {
            shutdown()
            
            scene.scaleMode = .aspectFill
            scene.size = (view?.bounds.size)!
            scene.anchorPoint = .zero
            
            skView.presentScene(scene, transition: transition)
        }
    }
    
    func resetScene(transition: SKTransition)
    {
        loadScene(scene: self, transition: transition)
    }
    
    func toMainMenu(transition: SKTransition)
    {
        loadScene(scene: MainMenu.init(), transition: transition)
    }
    
    func shutdown() {
        removeAllActions()
        removeAllChildren()
    }
}
