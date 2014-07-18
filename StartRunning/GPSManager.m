//
//  GPSManager.m
//  StartRunning
//
//  Created by Fernando Garcia Corrochano on 18/07/14.
//  Copyright (c) 2014 ironHack. All rights reserved.
//

#import "GPSManager.h"
@import MapKit;

@interface GPSManager ()<CLLocationManagerDelegate>


@property(nonatomic,strong)CLLocationManager *locationManager;

@end

@implementation GPSManager

-(CLLocationManager *)locationManager{
	if (_locationManager==nil) {
    _locationManager=[[CLLocationManager alloc]init];
	}
	return _locationManager;
}


-(NSMutableDictionary *)giveLocationIfStartCounter:(BOOL)counterStarted{
	
	NSMutableDictionary	*locationDictionary = [[NSMutableDictionary alloc] init];
	
	if (counterStarted) {
		self.locationManager.delegate        = self;  //SET YOUR DELEGATE HERE
		self.locationManager.desiredAccuracy = kCLLocationAccuracyBest; //SET THIS TO SPECIFY THE ACCURACY
		[self.locationManager startUpdatingLocation];
		
		
		CLLocationDegrees latitude=self.locationManager.location.coordinate.latitude;
		CLLocationDegrees longitude=self.locationManager.location.coordinate.longitude;
		
		NSLog(@"%@", self.locationManager.location);
		[self.locationManager stopUpdatingLocation];
		
		[locationDictionary setValue:@(latitude) forKey:@"latitude"];
		[locationDictionary setValue:@(longitude) forKey:@"longitude"];
		
		NSLog(@"latitude %f  ---  longitude%f", latitude,longitude);
		
	}
	return locationDictionary;
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
	NSLog(@"didFailWithError: %@", error);
	UIAlertView *errorAlert = [[UIAlertView alloc]
														 initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
	CLLocation *currentLocation = newLocation;
	NSLog(@"%@", currentLocation);
}





@end
