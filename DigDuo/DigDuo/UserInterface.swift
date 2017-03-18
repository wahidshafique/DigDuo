//
//  UserInterface.swift
//  DigDuo
//
//  Created by Digduo Team on 2017-03-17.
//  Copyright © 2017 Talpa Studios. All rights reserved.
//

import SpriteKit
import GameKit

class UserInterface : SKNode {
    init(size: CGSize)
    {
        super.init()
        
        xPixels = (size.width)/Globals.pixelsPerUnit
        yPixels = (size.height)/Globals.pixelsPerUnit
        zPosition = Globals.UIDepth
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // returns the given name. names can be different if you previously tried to assign that specific name
    func AddText(name: String, text: String, uiPos: CGPoint, fontColor: UIColor, size: CGFloat) -> String
    {
        var assignedName: String = name
        
        if uiNodes.keys.contains(where: {
            return $0 == self.name
        }){
           assignedName = name + String(UserInterface.textCount)
        }
        
        let newText = TextNode(text: text)
        newText.name = assignedName
        newText.fontSize = size
        newText.fontColor = fontColor
        
        addChild(newText)
        newText.position = uiToPixelPoint(point: uiPos)
        
        UserInterface.textCount += 1
        
        uiNodes[assignedName] = newText
        
        return assignedName
    }
    
    // returns the given name. names can be different if you previously tried to assign that specific name
    func AddButton(name: String, imageNamed: String, text: String, uiPos: CGPoint, fontColor: UIColor, size: CGSize,
                closure: @escaping () -> Void) -> String
    {
        var assignedName: String = name
        
        if uiNodes.keys.contains(where: {
            return $0 == self.name
        }){
            assignedName = name + String(UserInterface.buttonCount)
        }
        
        let button = ButtonNode(texture: SKTexture(imageNamed: imageNamed), color: .clear, size: size)
        
        print(size.height)
        button.touchClosure = closure
        button.name = assignedName        
        
        let newText = TextNode(text: text)
        newText.name = "txt-" + assignedName
        newText.fontSize = 30.0
        newText.fontColor = fontColor
        
        button.setText(text: newText)
        
        addChild(button)
        button.position = uiToPixelPoint(point: uiPos)
        
        uiNodes[assignedName] = button
        
        UserInterface.buttonCount += 1
        
        return assignedName
    }
    
    func onTouchDown(point: CGPoint)
    {
        for node in uiNodes {
            if let btn = node.value as? ButtonNode {
                
                if btn.contains(point) {
                    btn.onTouchDown()
                }
            }
        }
    }
    
    func onTouchUp(point: CGPoint)
    {
        for node in uiNodes {
            if let btn = node.value as? ButtonNode {
                if btn.contains(point) {
                    btn.onTouchUp()
                }
            }
        }
    }
    
    func GrabByName(nodeName: String) -> SimpleUI?
    {
        var node: SimpleUI? = nil
        
        if uiNodes.keys.contains(where: {
            return $0 == nodeName
        }) {
            node = uiNodes[nodeName]
        }
        
        return node
    }
    
    func RemoveByName(nodeName: String)
    {
        if uiNodes.keys.contains(where: {
            return $0 == nodeName
        }) {
            uiNodes.removeValue(forKey: nodeName)
        }
    }
    
    func uiToPixelPoint(point: CGPoint) -> CGPoint
    {
        return CGPoint(x: point.x*xPixels!, y: point.y*yPixels!)
    }
    
    func pixelToUIPoint(point: CGPoint) -> CGPoint
    {
        return CGPoint(x: point.x/xPixels!, y: point.y/yPixels!)
    }
    
    func clearAll()
    {
        removeAllActions()
        removeAllChildren()
        uiNodes.removeAll()
    }
    
    private var xPixels: CGFloat?
    private var yPixels: CGFloat?
    private static var textCount: Int = 0
    private static var buttonCount: Int = 0
    
    private var uiNodes: [String:SimpleUI] = [:]
}
