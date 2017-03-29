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

#include <math.h>

struct tuple {
    int a, b;
};

typedef struct tuple CTuple;

int GCD(CTuple fraction);


#endif /* mymath_h */
