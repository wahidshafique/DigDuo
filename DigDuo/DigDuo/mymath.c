//
//  mymath.c
//  DigDuo
//
//  Created by Derek Mallory on 2017-03-28.
//  Copyright © 2017 Talpa Studios. All rights reserved.
//

#include "mymath.h"

int GCD(CTuple fraction) {
    const int r = fraction.a % fraction.b;
    if (r) {
        fraction.a = fraction.b;
        fraction.b = r;
        
        return GCD(fraction);
    }
    
    return fraction.b;
}
