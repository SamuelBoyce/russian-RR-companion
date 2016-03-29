//
//  SMBRRDataSource.m
//  Russian Railroads Companion
//
//  Created by Samuel Boyce on 3/4/16.
//  Copyright © 2016 Samuel Boyce. All rights reserved.
//

#import "SMBRRDataSource.h"

@implementation SMBRRDataSource

+(instancetype)SMBRRSharedDataSource
{
    static SMBRRDataSource *dataSource = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataSource = [[SMBRRDataSource alloc]init];
    });
    
    return dataSource;
}

-(instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _player = [[SMBPlayer alloc] init];
    }
    
    return self;
}

@end
