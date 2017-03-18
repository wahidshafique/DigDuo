//
//  MainMenu.swift
//  DigDuo
//
//  Created by Digduo Team on 2017-03-17.
//  Copyright © 2017 Talpa Studios. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameoverScene: SKScene {
    private var ui : UserInterface?
    private var background: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        let dimensions = getDimensionsInScreen()
        ui = UserInterface(size: CGSize(width: dimensions.width, height: dimensions.height))
        
        background = SKSpriteNode(texture: SKTexture(imageNamed: "Background"), color: .blue, size: dimensions)
        background?.blendMode = .replace
        background?.zPosition = 0
        background?.colorBlendFactor = 1.0
        addChild(background!)
        background!.position += CGVector(dx: dimensions.width/2.0, dy: dimensions.height/2.0)
        
        addChild(ui!)
        
        ui?.AddText(name: "txt-gameover", text: "GAMEOVER!", uiPos: CGPoint(x: 50, y: 70), fontColor: .red, size: 72.0)
        ui?.AddButton(name: "button2", imageNamed: "button1", text: "RESTART", uiPos: CGPoint(x: 50, y: 55), fontColor: .black, size: CGSize(width: 175, height: 100), closure: {
                self.loadScene(sceneNamed: "GameScene", transition: SKTransition.crossFade(withDuration: 0.25))
        })
        ui?.AddButton(name: "button3", imageNamed: "button1", text: "MAIN MENU", uiPos: CGPoint(x: 50, y: 40), fontColor: .black, size: CGSize(width: 175, height: 100), closure: {
            self.loadScene(sceneNamed: "MainMenu", transition: SKTransition.crossFade(withDuration: 0.75))
        })
        ui?.AddButton(name: "button1", imageNamed: "button1", text: "???", uiPos: CGPoint(x: 50, y: 25), fontColor: .black, size: CGSize(width: 175, height: 100), closure: {
            if view != nil {
                let myScene = EasterEggScene(size: dimensions)
                myScene.scaleMode = .aspectFill
                myScene.size = (view.bounds.size)
                myScene.anchorPoint = .zero
                view.presentScene(myScene, transition: SKTransition.moveIn(with: SKTransitionDirection.up, duration: 1.0))
            }
        })
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
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
    
    func loadScene(sceneNamed: String, transition: SKTransition)
    {
        if let skView = view {
            shutdown()
            
            let myScene = SKScene(fileNamed: sceneNamed)
            myScene?.scaleMode = .aspectFill
            myScene?.size = (view?.bounds.size)!
            myScene?.anchorPoint = .zero
            
            skView.presentScene(myScene!, transition: transition)
        }
    }
    
    func resetScene()
    {
        loadScene(sceneNamed: (scene?.name!)!, transition: SKTransition.crossFade(withDuration: 0.25))
    }
    
    func toMainMenu()
    {
        
    }
    
    func shutdown() {
        removeAllActions()
        removeAllChildren()
    }
}
