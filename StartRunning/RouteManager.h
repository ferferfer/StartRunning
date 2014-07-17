//
//  RouteManager.h
//  StartRunning
//
//  Created by Fernando Garcia Corrochano on 16/07/14.
//  Copyright (c) 2014 ironHack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RouteManager : NSObject

-(NSInteger)calculateDistance:(NSDictionary *)route;
-(NSInteger)calculateSpeedWithDistance:(NSInteger)distance andTime:(NSInteger)time;
@end
