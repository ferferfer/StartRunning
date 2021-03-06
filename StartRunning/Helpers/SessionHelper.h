//
//  SessionHelper
//  StartRunning
//
//  Created by Fernando Garcia Corrochano on 16/07/14.
//  Copyright (c) 2014 ironHack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Route.h"
#import "Person.h"
@import MapKit;

@interface SessionHelper : NSObject

@property(nonatomic,strong)MKPolyline *routeLine;

-(double)calculateDistance:(Route *)route;
-(NSInteger)calculateSpeedWithDistance:(NSInteger)distance andTime:(NSInteger)time;
-(void) loadRoute:(NSArray *)coordinates;
-(double)calculateKcalWithWalking:(NSInteger)walkTime
											 andRunning:(NSInteger)runTime
											andDistance:(NSInteger)distance;

@end
