//
//  WanderState.swift
//  DigDuo
//
//  Created by Derek Mallory on 2017-04-16.
//  Copyright © 2017 Talpa Studios. All rights reserved.
//

import GameplayKit

class IdleState: GKState
{
    init(idleDelay seconds: TimeInterval)
    {
        idleDelay = seconds
        
        super.init()
    }
    
    override func didEnter(from previousState: GKState?)
    {
        hasEntered = true;
    }
    
    override func update(deltaTime seconds: TimeInterval)
    {
        if hasEntered && !canEnterNextState
        {
            passedTimeSinceEntry += seconds
        
            if passedTimeSinceEntry >= passedTimeSinceEntry
            {
                canEnterNextState = true
            }
        }
    }
    
    override func willExit(to nextState: GKState)
    {
        hasEntered = false;
        passedTimeSinceEntry = 0.0
        canEnterNextState = false
    }

    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is WanderState.Type
    }
    
    var CanEnterNextState: Bool {
        return canEnterNextState
    }
    
    private var canEnterNextState = false
    private var hasEntered = false
    
    private let idleDelay: TimeInterval
    
    private var passedTimeSinceEntry = 0.0
}
