////
////  WorldObject.swift
////
////  Created by team digduo on 2017-04-12.
////  Copyright © 2017 Team Digduo. All rights reserved.
////
//
//import GameKit
import SpriteKit
//
typealias WorldObjectID = UInt

enum WorldLayer : UInt32
{
    case None
    case Background
    case Level
    case Item
    case Enemy
    case Player
}

enum CollisionLayer : UInt32
{
    case Default
    case Player
    case Item
    case Enemy
    case Ignore
}

class WorldObject : SKNode
{
    init(associatedWorld world: World)
    {
        self.m_world = world
        
        // set the world id of the worldobject (starts from 1)
        WorldObject.CurrentWorldID += 1
        self.m_worldID = WorldObject.CurrentWorldID
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // FIELDS
    unowned var m_world: World
    private var m_worldID: WorldObjectID
    
    // COMPONENTS
    
    // PROPERTIES
    var LayerInWorld : WorldLayer
    {
        get { return WorldLayer(rawValue: UInt32(zPosition))! }
        set { zPosition = CGFloat(newValue.rawValue) }
    }
    
    // STATIC
    private static var CurrentWorldID: WorldObjectID = 0
}
//
//extension WorldObject
//{
//    func log(_ msg: String)
//    {
//        print("WorldObject \(self.worldID): " + msg)
//    }
//}
