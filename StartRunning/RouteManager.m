//
//  RouteManager.m
//  StartRunning
//
//  Created by Fernando Garcia Corrochano on 16/07/14.
//  Copyright (c) 2014 ironHack. All rights reserved.
//

#import "RouteManager.h"
@import MapKit;

@implementation RouteManager

-(double)calculateDistance:(Route *)route{
	double totalDistance=0;
	for (int i=0;i< [route.arrayOfCoordinates count]; i++) {
		NSMutableArray *array=[[NSMutableArray alloc]initWithArray:route.arrayOfCoordinates copyItems:NO];
		//Location 1
		NSMutableDictionary *dict1=[[NSMutableDictionary alloc] init];
		dict1 = [array objectAtIndex:i];
		NSNumber *latitude1=[dict1 valueForKey:@"latitude"];
		NSNumber *longitude1=[dict1 valueForKey:@"longitude"];;
		CLLocation *location1=[[CLLocation alloc]initWithLatitude:[latitude1 floatValue] longitude:[longitude1 floatValue]];

			NSMutableDictionary *dict2=[[NSMutableDictionary alloc] init];
			dict2 = [array objectAtIndex:i+1];
			NSNumber *latitude2=[dict2 valueForKey:@"latitude"];
			NSNumber *longitude2=[dict2 valueForKey:@"longitude"];;
			CLLocation *location2=[[CLLocation alloc]initWithLatitude:[latitude2 floatValue] longitude:[longitude2 floatValue]];

    
    CLLocationDistance distance = [location1 distanceFromLocation:location2];
		
		totalDistance+=distance;
		NSLog(@"dict1:%@ \n i:%i dict2:%@ DISTANCE:%f    TOTAL:%f",dict1.description,i,dict2.description,distance,totalDistance);
		if (i+2==[route.arrayOfCoordinates count]) {
			return totalDistance;
		}
	}
	return totalDistance;
}

-(NSInteger)calculateSpeedWithDistance:(NSInteger)distance andTime:(NSInteger)time{
	
	return distance/time/120;
}

@end
