//
//  MapViewController.m
//  StartRunning
//
//  Created by Fernando Garcia Corrochano on 21/07/14.
//  Copyright (c) 2014 ironHack. All rights reserved.
//

#import "MapViewController.h"

@import MapKit;

@interface MapViewController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (nonatomic,strong)MKPolylineView *routeLineView;
@property (nonatomic,copy)NSArray *arrayOfCoordinates;

@end

@implementation MapViewController

-(SessionHelper *)sessionHelper{
	if (_sessionHelper==nil) {
    _sessionHelper=[[SessionHelper alloc]init];
	}
	return _sessionHelper;
}

//-(Session *)session{
//	if (_session==nil) {
//    _session=[[Session alloc]init];
//	}
//	return _session;
//}

- (void)viewDidLoad{
	[super viewDidLoad];
	self.arrayOfCoordinates=[[NSArray alloc]initWithArray:self.session.route.arrayOfCoordinates];
	[self loadMapData];
}

-(void)loadMapData{
	[self.map setMapType:MKMapTypeHybrid];
	self.map.delegate=self;
	[self.sessionHelper loadRoute:self.arrayOfCoordinates];
	[self.map addOverlay:self.sessionHelper.routeLine];
	[self.map setVisibleMapRect:[self.sessionHelper.routeLine boundingMapRect]];
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id )overlay{
	MKOverlayView* overlayView = nil;
	
	if(overlay == self.sessionHelper.routeLine)		{
		//if we have not yet created an overlay view for this overlay, create it now.
		if(nil == self.routeLineView)			{
			self.routeLineView = [[MKPolylineView alloc] initWithPolyline:self.sessionHelper.routeLine];
			self.routeLineView.fillColor = [UIColor blueColor];
			self.routeLineView.strokeColor = [UIColor whiteColor];
			self.routeLineView.lineWidth = 12;
		}
		
		overlayView = self.routeLineView;
		
	}
	return overlayView;
	
}

- (IBAction)backPressed:(id)sender {
	[self dismissViewControllerAnimated:YES completion:nil];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
