//
//  RouteManager.m
//  StartRunning
//
//  Created by Fernando Garcia Corrochano on 16/07/14.
//  Copyright (c) 2014 ironHack. All rights reserved.
//

#import "RouteManager.h"

@interface RouteManager	()

@property(nonatomic)MKMapRect routeRect;

@end

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
		if (i+2==[route.arrayOfCoordinates count]) {
			return totalDistance;
		}
	}
	return totalDistance;
}

-(NSInteger)calculateSpeedWithDistance:(NSInteger)distance andTime:(NSInteger)time{
	if (time==0) {
    return 0;
	}
	return distance/time/120;
}

-(void) loadRoute:(NSArray *)coordinates{
	
	MKMapPoint northEastPoint;
	MKMapPoint southWestPoint;
	
	MKMapPoint* pointArr = malloc(sizeof(CLLocationCoordinate2D) * coordinates.count);
	
	for(int i = 0; i < coordinates.count; i++){
		NSMutableDictionary *position=[[NSMutableDictionary alloc]init];
		position=[coordinates objectAtIndex:i];
		
    CLLocationDegrees latitude = [[position valueForKey:@"latitude"] doubleValue];
    CLLocationDegrees longitude = [[position valueForKey:@"longitude"] doubleValue];
		
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
		
    MKMapPoint point = MKMapPointForCoordinate(coordinate);
		
		if (i == 0) {
			northEastPoint = point;
			southWestPoint = point;
    }
    else
			{
			if (point.x > northEastPoint.x)
				northEastPoint.x = point.x;
			if(point.y > northEastPoint.y)
				northEastPoint.y = point.y;
			if (point.x < southWestPoint.x)
				southWestPoint.x = point.x;
			if (point.y < southWestPoint.y)
				southWestPoint.y = point.y;
			}
		
    pointArr[i] = point;
		
	}
	
	self.routeLine = [MKPolyline polylineWithPoints:pointArr count:coordinates.count];
	
	self.routeRect = MKMapRectMake(southWestPoint.x, southWestPoint.y, northEastPoint.x - southWestPoint.x, northEastPoint.y - southWestPoint.y);
	
	free(pointArr);
	
	
}


@end
