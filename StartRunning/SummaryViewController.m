//
//  SummaryViewController.m
//  StartRunning
//
//  Created by Fernando Garcia Corrochano on 16/07/14.
//  Copyright (c) 2014 ironHack. All rights reserved.
//

#import "SummaryViewController.h"
#import "TimersManager.h"
@import MapKit;


@interface SummaryViewController ()
@property (weak, nonatomic) IBOutlet UITextField *totalWalkingTime;
@property (weak, nonatomic) IBOutlet UITextField *totalRunningTime;
@property (weak, nonatomic) IBOutlet UITextField *totalTime;
@property (weak, nonatomic) IBOutlet UITextField *totalDistance;
@property (weak, nonatomic) IBOutlet UITextField *totalCalories;
@property (weak, nonatomic) IBOutlet UITextField *totalAvSpeed;
@property (weak, nonatomic) IBOutlet MKMapView *map;

@property (nonatomic,strong) TimersManager *timersManager;

@end

@implementation SummaryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
	}
	return self;
}

-(TimersManager *)timersManager{
	if (_timersManager==nil) {
    _timersManager=[[TimersManager alloc]init];
	}
	return _timersManager;
}

- (void)viewDidLoad{
	[super viewDidLoad];
	[self loadSessionData];
}

-(void)loadSessionData{
	self.totalWalkingTime.text=[self.timersManager returnTimeFormatWithSeconds:self.session.totalWalking];
	self.totalRunningTime.text=[self.timersManager returnTimeFormatWithSeconds:self.session.totalRunning];
	NSInteger totalSessionTime=self.session.totalRunning+self.session.totalWalking;
	self.totalTime.text=[self.timersManager returnTimeFormatWithSeconds:totalSessionTime];
	self.totalDistance.text=[NSString stringWithFormat:@"%.1f Km", self.session.distance/1000];
	self.totalCalories.text=[NSString stringWithFormat:@"%li Kcal",(long)self.session.kcal];
	self.totalAvSpeed.text=[NSString stringWithFormat:@"%.1f Km/h",self.session.avSpeed];
}

-(void)paintRouteOnMap:(MKMapView *)map{
	
}

- (IBAction)backButtonPressed:(id)sender {
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
