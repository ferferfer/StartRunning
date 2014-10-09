//
//  ViewController.m
//  StartRunning
//
//  Created by Fernando Garcia Corrochano on 14/07/14.
//  Copyright (c) 2014 ironHack. All rights reserved.
//

#import "MainViewController.h"
#import "Session.h"
#import "Person.h"
#import "Route.h"
#import "SessionHelper.h"
#import "TimersManager.h"
#import "SummaryViewController.h"
#import "PlistManager.h"
#import "GenderViewController.h"
#import "GPSManager.h"
#import "UIColor+CustomColor.h"
#import "TextFormateer.h"
#import "MediaHelper.h"

@interface MainViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textFieldTimeWalking;
@property (weak, nonatomic) IBOutlet UITextField *textFieldTimeRunning;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UILabel *labelWalk;
@property (weak, nonatomic) IBOutlet UILabel *labelRun;

@property (nonatomic) NSInteger presetTimeToWalk;
@property (nonatomic) NSInteger	presetTimeToRun;
@property (nonatomic) NSInteger totalWalked;
@property (nonatomic) NSInteger	totalRunned;
@property (nonatomic) NSInteger totalSeconds;

@property	(nonatomic,strong)NSTimer *walkingTimer;
@property	(nonatomic,strong)NSTimer *runningTimer;

@property	(nonatomic)BOOL isFirstTime;

@property	(nonatomic,strong)Route *route;
@property	(nonatomic,strong)Session *session;
@property	(nonatomic,strong)TimersManager *timersManager;
@property	(nonatomic,strong)SummaryViewController	*summaryViewController;
@property	(nonatomic,strong)PlistManager	*plistManager;
@property	(nonatomic,strong)GenderViewController	*genderViewController;
@property	(nonatomic,strong)GPSManager *gpsManager;
@property (nonatomic,strong)MediaHelper *mediaHelper;

@end

@implementation MainViewController

- (instancetype)initWithCoder:(NSCoder *)coder{
	self = [super initWithCoder:coder];
	if (self) {
			[[UITabBar appearance] setSelectedImageTintColor:[UIColor appGreenColor]];
	}
	return self;
}

- (void)viewDidLoad{
	[super viewDidLoad];
	self.textFieldTimeWalking.delegate = self;
  self.textFieldTimeRunning.delegate = self;
	self.isFirstTime=YES;
}

-(MediaHelper *)mediaHelper{
	if (_mediaHelper==nil) {
    _mediaHelper=[[MediaHelper alloc]init];
	}
	return _mediaHelper;
}

-(Route *)route{
	if (_route==nil) {
    _route=[[Route alloc]init];
	}
	return _route;
}

-(GPSManager *)gpsManager{
	if (_gpsManager==nil) {
    _gpsManager=[[GPSManager alloc]init];
	}
	return _gpsManager;
}

-(GenderViewController *)genderViewController{
	if (_genderViewController==nil) {
    _genderViewController=[[GenderViewController alloc]init];
	}
	return _genderViewController;
}

-(PlistManager *)plistManager{
	if (_plistManager==nil) {
    _plistManager=[[PlistManager alloc]init];
	}
	return _plistManager;
}

-(TimersManager *)timersManager{
	if (_timersManager==nil) {
    _timersManager=[[TimersManager alloc]init];
	}
	return _timersManager;
}

-(SummaryViewController *)summaryViewController{
	if (_summaryViewController==nil) {
    _summaryViewController=[[SummaryViewController alloc]init];
	}
	return _summaryViewController;
}

-(Session *)session{
	if (_session==nil) {
    _session=[[Session alloc]init];
	}
	return _session;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	[self.view endEditing:YES];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{

	if (textField == self.textFieldTimeWalking) {
		self.textFieldTimeWalking.text =[TextFormateer returnCorrectFormatForTextField:textField];
	}
	if (textField == self.textFieldTimeRunning) {
		self.textFieldTimeRunning.text =[TextFormateer returnCorrectFormatForTextField:textField];
	}
	[self enableButtons];
}

-(void)enableButtons{
	if ([TextFormateer textFieldIsNillTime:self.textFieldTimeRunning] ||
			[TextFormateer textFieldIsNillTime:self.textFieldTimeWalking]) {
		self.playButton.enabled=NO;
	}else{
    self.playButton.enabled=YES;
	}
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
	if ([self.textFieldTimeWalking isEditing]) {
		if([TextFormateer lengthMoreThan:5 ofTextField:self.textFieldTimeWalking andString:string]){
				return NO;
			}
		if ([TextFormateer shouldAddColonTo:self.textFieldTimeWalking withString:string]) {
			self.textFieldTimeWalking.text=[TextFormateer addColonTo:textField];
			return YES;
		}
	}
	if ([self.textFieldTimeRunning isEditing]) {
		if([TextFormateer lengthMoreThan:5 ofTextField:self.textFieldTimeRunning andString:string]){
			return NO;
		}
		if ([TextFormateer shouldAddColonTo:self.textFieldTimeRunning withString:string]) {
			self.textFieldTimeRunning.text=[TextFormateer addColonTo:textField];
			return YES;
		}
	}
	return YES;
}



- (IBAction)playPressed:(id)sender {

	self.playButton.hidden=YES;
	self.pauseButton.hidden=NO;
	self.stopButton.enabled=YES;
	self.textFieldTimeRunning.enabled=NO;
	self.textFieldTimeWalking.enabled=NO;
	[self.gpsManager startCounter:YES];
	
	//only first time
	if (self.isFirstTime) {
		self.isFirstTime=NO;
		self.labelWalk.text=@"Walking";
		
		self.presetTimeToWalk=[self.timersManager calculateSeconds:self.textFieldTimeWalking.text];
		self.presetTimeToRun=[self.timersManager calculateSeconds:self.textFieldTimeRunning.text];
		
		self.totalSeconds=[self.timersManager calculateSeconds:self.textFieldTimeWalking.text];
		self.walkingTimer=[self startTimer];
		
	}else{
		
		NSUInteger actualTime=[self.timersManager calculateSeconds:self.textFieldTimeRunning.text];
		if (self.presetTimeToRun != actualTime) {
			self.totalSeconds=[self.timersManager calculateSeconds:self.textFieldTimeRunning.text];
			self.runningTimer=[self startTimer];
		}else{
			self.totalSeconds=[self.timersManager calculateSeconds:self.textFieldTimeWalking.text];
			self.walkingTimer=[self startTimer];
		}
	}
}

-(NSTimer *)startTimer{
	return [NSTimer scheduledTimerWithTimeInterval:1.0
																					target:self
																				selector:@selector(updateCountdown)
																				userInfo:nil
																				 repeats:YES];
}

-(void)change:(UILabel*)label withText:(NSString *)text{
	label.text=text;
}

-(void) updateCountdown {
	int minutes, seconds;
	
	minutes = (self.totalSeconds %3600) / 60;
	seconds = (self.totalSeconds %3600) % 60;
	
	if ([self.runningTimer isValid]) {
		self.textFieldTimeRunning.text = [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
	}
	if ([self.walkingTimer isValid]) {
		self.textFieldTimeWalking.text = [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
	}
	
	if ([self.textFieldTimeWalking.text isEqualToString:@"00:-1"]) {
		self.textFieldTimeWalking.text=[self.timersManager returnTimeFormatWithSeconds:self.presetTimeToWalk];
		self.totalSeconds=[self.timersManager calculateSeconds:self.textFieldTimeRunning.text];
		[self.walkingTimer invalidate];
		self.walkingTimer = nil;
		self.runningTimer=[self startTimer];
		[self.mediaHelper VibrateAndSay:@"run"];
		self.labelRun.text=@"Running";
		self.labelWalk.text=@"Walk";
		
		self.totalWalked+=self.presetTimeToWalk;
	}
	if ([self.textFieldTimeRunning.text isEqualToString:@"00:-1"]) {
		self.textFieldTimeRunning.text=[self.timersManager returnTimeFormatWithSeconds:self.presetTimeToRun];
		self.totalSeconds=[self.timersManager calculateSeconds:self.textFieldTimeWalking.text];
		[self.runningTimer invalidate];
		self.runningTimer = nil;
		self.walkingTimer=[self startTimer];
		
		[self.mediaHelper VibrateAndSay:@"walk"];
		self.labelRun.text=@"Run";
		self.labelWalk.text=@"Walking";
		
		self.totalRunned+=self.presetTimeToRun;
	}
	
	self.totalSeconds--;
	
	[self.route addPoint:self.gpsManager.locationDictionary];
	
}
- (IBAction)pausePressed:(id)sender {
	[self.walkingTimer invalidate];
	self.walkingTimer = nil;
	[self.runningTimer invalidate];
	self.runningTimer = nil;
	self.playButton.hidden=NO;
	self.pauseButton.hidden=YES;
}

- (IBAction)stopPressed:(id)sender {
	
	[self.walkingTimer invalidate];
	self.walkingTimer = nil;
	
	[self.runningTimer invalidate];
	self.runningTimer = nil;
	
	self.playButton.hidden=NO;
	self.pauseButton.hidden=YES;
	self.stopButton.enabled=NO;
	
	self.textFieldTimeRunning.enabled=YES;
	self.textFieldTimeWalking.enabled=YES;
	
	self.isFirstTime=YES;
	
	[self.gpsManager startCounter:NO];
	
	[self restartCounters];
}

-(void)restartCounters{
	self.textFieldTimeRunning.text=[self.timersManager returnTimeFormatWithSeconds:self.presetTimeToRun];
	self.textFieldTimeWalking.text=[self.timersManager returnTimeFormatWithSeconds:self.presetTimeToWalk];
	self.totalRunned=0;
	self.totalWalked=0;
	self.route=[[Route alloc]init];
	self.labelRun.text=@"Run";
	self.labelWalk.text=@"Walk";
}

-(void)saveSession{
	if ([self.runningTimer isValid]) {
		self.totalRunned+=self.presetTimeToRun-[self.timersManager calculateSeconds:self.textFieldTimeRunning.text];
	}
	
	if ([self.walkingTimer isValid]) {
		self.totalWalked+=self.presetTimeToWalk-[self.timersManager calculateSeconds:self.textFieldTimeWalking.text];
	}
	SessionHelper *sessionHelper=[[SessionHelper alloc]init];
	double distance=[sessionHelper calculateDistance:self.route];
	NSInteger totalSessionTime=self.totalWalked+self.totalRunned;
	NSInteger avSpeed=[sessionHelper calculateSpeedWithDistance:distance andTime:totalSessionTime];
	
	double kCal=[sessionHelper calculateKcalWithWalking:self.totalWalked andRunning:self.totalRunned andDistance:distance];
	
	self.session=[self.session initWithDate:[NSDate date] andTotalRunning:self.totalRunned andTotalWalking:self.totalWalked andTimeRunning:self.presetTimeToRun andTimewalking:self.presetTimeToWalk andDistance:distance andAvSpeed:avSpeed andKcal:kCal  andRoute:self.route];
	
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
	
	if ([[segue identifier] isEqualToString:@"summarySegue"]) {
		[self saveSession];
		[self.plistManager addSession:self.session];
		SummaryViewController	*summaryView = [segue destinationViewController];
		summaryView.session = self.session;
		summaryView.navigationBar=NO;
	}
}



@end
