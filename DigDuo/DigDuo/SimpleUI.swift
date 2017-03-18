//
//  SimpleUI.swift
//  DigDuo
//
//  Created by Digduo Team on 2017-03-17.
//  Copyright © 2017 Talpa Studios. All rights reserved.
//

import Foundation

enum SimpleUIType
{
    case text, button, container
}

protocol SimpleUI : class {
    var Name: String {
        get
    }
    
    var getUIType : SimpleUIType {
        get
    }
}
