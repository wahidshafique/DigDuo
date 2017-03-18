//
//  mymath.h
//  Endian
//
//  Created by Derek Mallory on 2017-03-05.
//  Copyright © 2017 Derek Mallory. All rights reserved.
//

// add whatever arbitrary math functions here

#ifndef mymath_h
#define mymath_h

#include <stdio.h>
#include <math.h>

struct tuple {
    int a, b;
};

typedef struct tuple CTuple;

int GCD(CTuple fraction) {
    const int r = fraction.a % fraction.b;
    if (r) {
        fraction.a = fraction.b;
        fraction.b = r;
        
        return GCD(fraction);
    }
    
    return fraction.b;
}


#endif /* mymath_h */
