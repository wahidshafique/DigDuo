//
//  MainMenu.swift
//  DigDuo
//
//  Created by Digduo Team on 2017-03-17.
//  Copyright © 2017 Talpa Studios. All rights reserved.
//

import SpriteKit
import GameplayKit

class Leaderboard: SKScene {
    private var ui : UserInterface?
    private var background: SKSpriteNode?
    private var npc: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        let dimensions = getDimensionsInScreen()
        ui = UserInterface(size: CGSize(width: dimensions.width, height: dimensions.height))
        
        background = SKSpriteNode(texture: SKTexture(imageNamed: "Background"), color: .blue, size: dimensions)
        background?.blendMode = .replace
        background?.zPosition = 0
        background?.colorBlendFactor = 1.0
        addChild(background!)
        background!.position += CGVector(dx: dimensions.width/2.0, dy: dimensions.height/2.0)
        
        let tex = SKTexture(imageNamed: "NPC")
        npc = SKSpriteNode(texture: tex, color: .black, size: tex.size())
        
        npc?.zPosition = 1
        npc?.colorBlendFactor = 1.0
        addChild(npc!)
        npc!.position += CGVector(dx: dimensions.width/2.0, dy: dimensions.height/2.0)
        
        npc!.run(SKAction.repeatForever(SKAction.rotate(byAngle: 360, duration: 1.25)))
        npc!.run(SKAction.repeatForever(SKAction.sequence([.scale(to: 2.0, duration: 1.0), .scale(to: 1.0, duration: 1.0)])))
        
        addChild(ui!)
        
        ui?.AddText(name: "txt-title", text: "LEADERBOARD", uiPos: CGPoint(x: 50, y: 75), fontColor: .red, size: 56.0)
        
        ui?.AddText(name: "txt-title", text: "1. 4096", uiPos: CGPoint(x: 50, y: 60), fontColor: .yellow, size: 48.0)
        ui?.AddText(name: "txt-title", text: "2. 2048", uiPos: CGPoint(x: 50, y: 55), fontColor: .yellow, size: 44.0)
        ui?.AddText(name: "txt-title", text: "3. 1024", uiPos: CGPoint(x: 50, y: 50), fontColor: .yellow, size: 40.0)
        ui?.AddText(name: "txt-title", text: "4. 512", uiPos: CGPoint(x: 50, y: 45), fontColor: .yellow, size: 36.0)
        ui?.AddText(name: "txt-title", text: "5. 256", uiPos: CGPoint(x: 50, y: 40), fontColor: .yellow, size: 32.0)
        ui?.AddText(name: "txt-title", text: "6. 128", uiPos: CGPoint(x: 50, y: 35), fontColor: .yellow, size: 28.0)
        
        ui?.AddButton(name: "button1", imageNamed: "button1", text: "MENU", uiPos: CGPoint(x: 50, y: 20), fontColor: .black, size: CGSize(width: 175, height: 75), closure: {
                self.loadScene(sceneNamed: "MainMenu", transition: SKTransition.crossFade(withDuration: 0.75))
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
        
        print(sceneNamed)
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
