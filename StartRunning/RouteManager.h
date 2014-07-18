//
//  RouteManager.h
//  StartRunning
//
//  Created by Fernando Garcia Corrochano on 16/07/14.
//  Copyright (c) 2014 ironHack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Route.h"

@interface RouteManager : NSObject

-(NSInteger)calculateDistance:(Route *)route;
-(NSInteger)calculateSpeedWithDistance:(NSInteger)distance andTime:(NSInteger)time;
@end
