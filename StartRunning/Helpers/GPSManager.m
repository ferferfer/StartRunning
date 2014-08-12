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

- (id)init{
	_locationDictionary=[[NSMutableDictionary alloc]init];
	_locationManager=[[CLLocationManager alloc]init];
	return self;
}

-(CLLocationManager *)locationManager{
	if (_locationManager==nil) {
    _locationManager=[[CLLocationManager alloc]init];
	}
	return _locationManager;
}

-(void)startCounter:(BOOL)counterStarted{
	
	if (counterStarted) {
		if ([CLLocationManager locationServicesEnabled]) {
			self.locationManager.delegate        = self;  //SET YOUR DELEGATE HERE
			self.locationManager.desiredAccuracy = kCLLocationAccuracyBest; //SET THIS TO SPECIFY THE ACCURACY
			self.locationManager.distanceFilter=10;
			[self.locationManager startUpdatingLocation];
		}
	}else{
		if ([CLLocationManager locationServicesEnabled]) {
			[self.locationManager stopUpdatingLocation];
		}
	}
}


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
	NSLog(@"didFailWithError: %@", error);
	UIAlertView *errorAlert = [[UIAlertView alloc]
														 initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
	
	CLLocationDegrees latitude=newLocation.coordinate.latitude;
	CLLocationDegrees longitude=newLocation.coordinate.longitude;
	
	self.locationDictionary=[[NSMutableDictionary alloc]init];
	[self.locationDictionary setValue:@(latitude) forKey:@"latitude"];
	[self.locationDictionary setValue:@(longitude) forKey:@"longitude"];
	
	NSLog(@"latitude %f  ---  longitude%f", latitude,longitude);
	
}


@end
