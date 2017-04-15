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
    //TODO temp, abstract it later
    private var playerAnim: Animator?
    private var player :Player?
    private var cam:SKCameraNode?
    
    private var ui : UserInterface?
    private var uiElementNames = [String]()
    private var background: SKSpriteNode?
    private var npc: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        self.backgroundColor = UIColor.brown
        let dimensions = getDimensionsInScreen()
        ui = UserInterface(size: CGSize(width: dimensions.width, height: dimensions.height))
        
        background = SKSpriteNode(texture: SKTexture(imageNamed: "Background"), color: .white, size: CGSize(width: 1920, height: 1080))
        background?.blendMode = .replace
        background?.zPosition = 0
        background?.colorBlendFactor = 1.0
        addChild(background!)
        background!.position += CGVector(dx: dimensions.width/4.0, dy: dimensions.height/2.0)
    
        
        //addChild(ui!)
        print("dimension x \(dimensions.width) \n")
        print("dimension y \(dimensions.height) \n")
        let scoreTxt = ui?.AddText(name: "txt-score", text: "Score: 000", uiPos: CGPoint(x: 15, y: 45), fontColor: .yellow, size: 25.0)
        let pauseButton = ui?.AddButton(name: "btn-pause", imageNamed: "pause", text: "", uiPos: CGPoint(x: 40, y: 45), fontColor: .clear, size: CGSize(width: 60, height: 60), closure: {
            self.loadScene(scene: GameoverScene.init(), transition: SKTransition.crossFade(withDuration: 0.35))
        })
        
        
        // storing these keys in case we need to access them later through the ui
        if let score = scoreTxt{
            uiElementNames.append(score)
        }
        if let pause = pauseButton {
            uiElementNames.append(pause)
        }
        //addChild(ui!)

        
        //Player = new Pl
        player =  Player()
        self.addChild((player?.sprite)!)
        cameraSpawn()
        //playerAnimate()
        var enemy = Enemy()
        self.addChild(enemy)
        

    }
    
    func cameraSpawn() {
        //todo, migrate to world..
        cam = SKCameraNode()
        self.camera = cam
        // Constrain the camera to stay a constant distance of 0 points from the player node.
        let zeroRange = SKRange(constantValue: 0.0)
        let playerLocationConstraint = SKConstraint.distance(zeroRange, to: (player?.sprite)!)
        
        // get the scene size as scaled by `scaleMode = .AspectFill`
        let scaledSize = CGSize(width: size.width * (camera?.xScale)!, height: size.height * (camera?.yScale)!)
        
        // get the frame of the entire level contents
        let boardNode = background
        let boardContentRect = boardNode?.calculateAccumulatedFrame()
        
        // inset that frame from the edges of the level
        // inset by `scaledSize / 2 - 100` to show 100 pt of black around the level
        // (no need for `- 100` if you want zero padding)
        // use min() to make sure we don't inset too far if the level is small
        let xInset = min((scaledSize.width / 2) - 100.0, (boardContentRect?.width)! / 2)
        let yInset = min((scaledSize.height / 2) - 100.0, (boardContentRect?.height)! - (boardNode?.size.height)!)
        let insetContentRect = boardContentRect?.insetBy(dx: xInset, dy: yInset)
        
        // use the corners of the inset as the X and Y range of a position constraint
        let xRange = SKRange(lowerLimit: (insetContentRect?.minX)!, upperLimit: (insetContentRect?.maxX)!)
        let yRange = SKRange(lowerLimit: (insetContentRect?.minY)!, upperLimit: (insetContentRect?.maxY)!)
        let levelEdgeConstraint = SKConstraint.positionX(xRange, y: yRange)
        levelEdgeConstraint.referenceNode = boardNode
        
        
        cam?.constraints = [playerLocationConstraint, levelEdgeConstraint]
        self.addChild(cam!)
        cam?.addChild(ui!)
    }
    

    
    func touchDown(atPoint pos : CGPoint) {
        player?.sprite.rotateVersus(destPoint: pos)
        player?.sprite.run(SKAction.move(to: pos, duration: 1.0))
        ui!.onTouchDown(point: pos)
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        player?.sprite.rotateVersus(destPoint: pos)
        player?.sprite.run(SKAction.move(to: pos, duration: 1.0))
        // TODO: notify ui
        // TODO: notify game
    }
    
    func touchUp(atPoint pos : CGPoint) {
        ui!.onTouchUp(point: pos)
        // TODO: notify ui
        // TODO: notify game
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: self) {
            player?.sprite.rotateVersus(destPoint: location)
            player?.sprite.run(SKAction.move(to: location, duration: 1.0))
        }
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
        super.update(currentTime)
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
