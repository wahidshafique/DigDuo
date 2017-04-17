//
//  Player.swift
//  DigDuo
//
//  Created by Tech on 2017-04-14.
//  Copyright © 2017 Talpa Studios. All rights reserved.
//

import GameplayKit

class EnemyEntity: GKEntity {
    
    init(player: PlayerEntity?)
    {
        self.player = player
        
        super.init()
        
        self.stateMachine = GKStateMachine.init(states: [
            IdleState.init(idleDelay: TimeInterval(idleDelay)), WanderState.init(enemyEntity: self, wanderRadius: self.wanderRadius, wanderSpeed: self.wanderSpeed)])
        
        self.stateMachine?.enter(IdleState.self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval)
    {
        super.update(deltaTime: seconds)
        self.stateMachine?.update(deltaTime: seconds)
        
        if let state = self.stateMachine?.currentState
        {
            if let s = state as? IdleState
            {
                let result = s.CanEnterNextState
                
                if result
                {
                    DecideStateFromIdle()
                }
            }
        }
    }
    
    var v: Int = 0;
    private func DecideStateFromIdle()
    {
        v += 1
        let closeToPlayer = WithinPlayerRadius()
        print(v)
        // seek
        if (closeToPlayer)
        {
            // TODO: enter seek state
        }
        // wander
        else
        {
            let didMakeTransition = stateMachine!.enter(WanderState.self)
            
            if didMakeTransition
            {
                if let currentState = self.CurrentState as? WanderState
                {
                    if currentState.PointIsSet
                    {
                        let moveComp = component(ofType: EnemyMoveComponent.self)
                        
                        moveComp!.moveToPoint(currentState.currentTarget!, duration: TimeInterval(1.0/self.wanderSpeed))
                    }
                }
            }
        }
    }
    
    private func WithinPlayerRadius() -> Bool
    {
        if let playerMoveComp = player?.component(ofType: MoveComponent.self)
        {
            let playerPos = playerMoveComp.sprite.position
            let distance = (playerPos - PixelPosition!).magnitude
            
            return distance <= seekRadius
        }
        
        return false
    }
    
    // ai fields
    var stateMachine: GKStateMachine?
    
    private var wanderRadius: CGFloat = 75.0
    private var wanderSpeed: CGFloat = 5.0
    
    private var idleDelay: CGFloat = 3.0
    
    private var seekRadius: CGFloat = 3.0
    
    weak var player: PlayerEntity?
    
    // ai properties
    var CurrentState: GKState?
    {
        return self.stateMachine?.currentState
    }
    
    var WanderRadius: CGFloat {
        get { return wanderRadius }
        set {
            wanderRadius = newValue
            
        }
    }
    
    var PixelPosition : CGPoint?
    {
        get {
            let visComp = component(ofType: EnemyVisualComponent.self)
            
            return visComp?.sprite.position
        }
    }
}
