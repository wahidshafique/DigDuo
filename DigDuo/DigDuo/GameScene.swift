//
//  MainMenu.swift
//  DigDuo
//
//  Created by Digduo Team on 2017-03-17.
//  Copyright © 2017 Talpa Studios. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    private var ui : UserInterface?
    private var uiElementNames = [String]()
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
        
        let scoreTxt = ui?.AddText(name: "txt-score", text: "Score: 000", uiPos: CGPoint(x: 25, y: 85), fontColor: .yellow, size: 25.0)
        let pauseButton = ui?.AddButton(name: "btn-pause", imageNamed: "pause", text: "", uiPos: CGPoint(x: 80, y: 85), fontColor: .clear, size: CGSize(width: 60, height: 60), closure: {
            self.loadScene(scene: GameoverScene.init(), transition: SKTransition.crossFade(withDuration: 0.35))
        })
        
        // storing these keys in case we need to access them later through the ui
        if let score = scoreTxt{
            uiElementNames.append(score)
        }
        if let pause = pauseButton {
            uiElementNames.append(pause)
        }
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
    
    func resetScene()
    {
        loadScene(scene: self, transition: SKTransition.crossFade(withDuration: 0.25))
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
