//
//  RouteManager.h
//  StartRunning
//
//  Created by Fernando Garcia Corrochano on 16/07/14.
//  Copyright (c) 2014 ironHack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Route.h"
@import MapKit;

@interface RouteManager : NSObject

@property(nonatomic,strong)MKPolyline *routeLine;

-(double)calculateDistance:(Route *)route;
-(NSInteger)calculateSpeedWithDistance:(NSInteger)distance andTime:(NSInteger)time;
-(void) loadRoute:(NSArray *)coordinates;

@end
