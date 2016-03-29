//
//  SMBPlayer.m
//  Russian Railroads Companion
//
//  Created by Samuel Boyce on 3/4/16.
//  Copyright © 2016 Samuel Boyce. All rights reserved.
//

#import "SMBPlayer.h"

@implementation SMBPlayer

-(instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _score = 0;
        _xSiberianVal = 0;
        _stPeterVal = 0;
        _kievVal = 0;
        _revalOn = NO;
    }
    
    return self;
}

@end
