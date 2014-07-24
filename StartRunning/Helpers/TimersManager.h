//
//  TimersManager.h
//  StartRunning
//
//  Created by Fernando Garcia Corrochano on 15/07/14.
//  Copyright (c) 2014 ironHack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimersManager : NSObject

-(NSUInteger)calculateSeconds:(NSString *)time;
-(NSString *)returnTimeFormatWithSeconds:(NSUInteger)seconds;


@end
