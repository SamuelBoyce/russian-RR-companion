//
//  SMBRRDataSource.h
//  Russian Railroads Companion
//
//  Created by Samuel Boyce on 3/4/16.
//  Copyright © 2016 Samuel Boyce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMBPlayer.h"

@interface SMBRRDataSource : NSObject

@property (nonatomic, strong) SMBPlayer *player;

+(instancetype)SMBRRSharedDataSource;

@end
