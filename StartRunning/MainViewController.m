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
#import "RouteManager.h"
#import "TimersManager.h"
#import "SummaryViewController.h"
#import "PlistManager.h"
#import "GenderViewController.h"
@import AVFoundation;

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

@property (nonatomic) int totalSeconds;
@property	(nonatomic,strong)NSTimer *walkingTimer;
@property	(nonatomic,strong)NSTimer *runningTimer;

@property	(nonatomic)BOOL isFirstTime;
@property (strong, nonatomic)	NSMutableDictionary	*route;

@property	(nonatomic,strong)Session *session;
@property	(nonatomic,strong)TimersManager *timersManager;
@property	(nonatomic,strong)SummaryViewController	*summaryViewController;
@property	(nonatomic,strong)PlistManager	*plistManager;
@property	(nonatomic,strong)GenderViewController	*genderViewController;
@end

@implementation MainViewController


- (void)viewDidLoad{
	[super viewDidLoad];
	self.textFieldTimeWalking.delegate = self;
  self.textFieldTimeRunning.delegate = self;
	[[UITabBar appearance] setSelectedImageTintColor:[self colorWithRed:46 green:204 blue:113]];
	self.isFirstTime=YES;
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


- (UIColor *)colorWithRed:(NSUInteger)red
                    green:(NSUInteger)green
                     blue:(NSUInteger)blue
{
	return [UIColor colorWithRed:red/255.f green:green/255.f blue:blue/255.f alpha:1.f];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	[self.view endEditing:YES];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
	NSString *mins;
	NSString *secs;
	if (textField == self.textFieldTimeWalking) {
		//The user left the imput this way 12:3, the logic says that he wants to input 01:23
		if (self.textFieldTimeWalking.text.length ==4) {
			mins=[self.textFieldTimeWalking.text substringToIndex:1];
			secs=[[self.textFieldTimeWalking.text substringFromIndex:1] stringByReplacingOccurrencesOfString:@":" withString:@""];
			self.textFieldTimeWalking.text=[NSString stringWithFormat:@"0%@:%@",mins,secs ];
		}
		if (self.textFieldTimeWalking.text.length<3) {
			//the user cancelled
			if (self.textFieldTimeWalking.text.length==0) {
				mins=@"00";
			}
			//The user left the imput this way 1, the logic says that he wants to input 01:00
			if (self.textFieldTimeWalking.text.length==1) {
				mins=[NSString stringWithFormat:@"0%@",self.textFieldTimeWalking.text];
			}
			//The user left the imput this way 10, the logic says that he wants to input 10:00
			if (self.textFieldTimeWalking.text.length==2) {
				mins=self.textFieldTimeWalking.text;
			}
			secs=@"00";
			self.textFieldTimeWalking.text=[NSString stringWithFormat:@"%@:%@",mins,secs ];
		}
	}
	if (textField == self.textFieldTimeRunning) {
		//The user left the imput this way 12:3, the logic says that he wants to input 01:23
		if (self.textFieldTimeRunning.text.length ==4) {
			mins=[self.textFieldTimeRunning.text substringToIndex:1];
			secs=[[self.textFieldTimeRunning.text substringFromIndex:1] stringByReplacingOccurrencesOfString:@":" withString:@""];
			self.textFieldTimeRunning.text=[NSString stringWithFormat:@"0%@:%@",mins,secs ];
		}
		if (self.textFieldTimeRunning.text.length<3) {
			//the user cancelled
			if (self.textFieldTimeRunning.text.length==0) {
				mins=@"00";
			}
			//The user left the imput this way 1, the logic says that he wants to input 01:00
			if (self.textFieldTimeRunning.text.length==1) {
				mins=[NSString stringWithFormat:@"0%@",self.textFieldTimeRunning.text];
			}
			//The user left the imput this way 10, the logic says that he wants to input 10:00
			if (self.textFieldTimeRunning.text.length==2) {
				mins=self.textFieldTimeRunning.text;
			}
			secs=@"00";
			self.textFieldTimeRunning.text=[NSString stringWithFormat:@"%@:%@",mins,secs ];
		}
	}
	[self enableButtons];
}

-(void)enableButtons{
	if ((![self.textFieldTimeRunning.text isEqual:@""] &&	![self.textFieldTimeWalking.text isEqual:@""]) &&
			(![self.textFieldTimeRunning.text isEqual:@"00:00"] &&	![self.textFieldTimeWalking.text isEqual:@"00:00"]) ) {
    self.playButton.enabled=YES;
		self.stopButton.enabled=YES;
	}
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
	if ([self.textFieldTimeWalking isEditing]) {
		if (self.textFieldTimeWalking.text)
			if (self.textFieldTimeWalking.text.length + string.length >5) {
				return NO;
			}
		if (self.textFieldTimeWalking.text.length ==2 && ![string isEqualToString:@""]) {
			self.textFieldTimeWalking.text=[self.textFieldTimeWalking.text stringByAppendingString:@":"];
			return YES;
		}
	}
	
	if ([self.textFieldTimeRunning isEditing]) {
		if (self.textFieldTimeWalking.text.length == 4) {
			NSString *mins=[self.textFieldTimeWalking.text substringToIndex:1];
			NSString *secs=[[self.textFieldTimeWalking.text substringFromIndex:1] stringByReplacingOccurrencesOfString:@":" withString:@""];
			self.textFieldTimeWalking.text=[NSString stringWithFormat:@"0%@:%@",mins,secs ];
		}
		if (self.textFieldTimeRunning.text.length + string.length >5) {
			return NO;
		}
		if (self.textFieldTimeRunning.text.length ==2 && ![string isEqualToString:@""]) {
			self.textFieldTimeRunning.text=[self.textFieldTimeRunning.text stringByAppendingString:@":"];
			return YES;
		}
	}
	return YES;
}



- (IBAction)playPressed:(id)sender {
	self.playButton.hidden=YES;
	self.pauseButton.hidden=NO;
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

-(void)VibrateAndSay:(NSString *)sentence{
	AVSpeechSynthesizer * syn = [[AVSpeechSynthesizer alloc] init];
	AVSpeechUtterance *string=[[AVSpeechUtterance alloc]initWithString:sentence];
	[string setRate:AVSpeechUtteranceMinimumSpeechRate];
	[string setVoice:[AVSpeechSynthesisVoice voiceWithLanguage:@"en-us"]];
	[syn speakUtterance:string];
	//Vibrate
	AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

-(void)change:(UILabel*)label withText:(NSString *)text{
	label.text=text;
}

-(void) updateCountdown {
	int minutes, seconds;
	
	minutes = (self.totalSeconds % 3600) / 60;
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
		[self VibrateAndSay:@"Start running!"];
		self.labelRun.text=@"Running";
		self.labelWalk.text=@"Walk";
	}
	if ([self.textFieldTimeRunning.text isEqualToString:@"00:-1"]) {
		
		self.textFieldTimeRunning.text=[self.timersManager returnTimeFormatWithSeconds:self.presetTimeToRun];
		self.totalSeconds=[self.timersManager calculateSeconds:self.textFieldTimeWalking.text];
		[self.runningTimer invalidate];
		self.runningTimer = nil;
		self.walkingTimer=[self startTimer];

		[self VibrateAndSay:@"Start walking!"];
		self.labelRun.text=@"Run";
		self.labelWalk.text=@"Walking";
	}
	
	self.totalSeconds--;
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
	self.textFieldTimeWalking.text=[self.timersManager returnTimeFormatWithSeconds:self.presetTimeToWalk];
	
	[self.runningTimer invalidate];
	self.runningTimer = nil;
	self.textFieldTimeRunning.text=[self.timersManager returnTimeFormatWithSeconds:self.presetTimeToRun];
	
	self.playButton.hidden=NO;
	self.pauseButton.hidden=YES;
	
	self.isFirstTime=YES;

//	self.session=[self.session initWithDate:[NSDate date] andTotalRunning:self.totalRunned andTotalWalking:self.totalWalked andTimeRunning:self.presetTimeToRun andTimewalking:self.presetTimeToWalk andDistance:distance andAvSpeed:avSpeed andRoute:self.route];


}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

	if ([[segue identifier] isEqualToString:@"summarySegue"]) {
		RouteManager *routeManager=[[RouteManager alloc]init];
		NSInteger distance=[routeManager calculateDistance:self.route];
		NSInteger totalSessionTime=self.totalRunned + self.totalWalked;
		NSInteger avSpeed=[routeManager calculateSpeedWithDistance:(NSInteger)distance andTime:(NSInteger)totalSessionTime];
		
		Session	*mySession=[[Session alloc] initWithDate:[NSDate date] andTotalRunning:0 andTotalWalking:0 andTimeRunning:0 andTimewalking:0 andDistance:0 andAvSpeed:0 andRoute:[NSDictionary dictionary]];
		
		[Session storeSession:mySession];
	
		SummaryViewController	*summaryView = [segue destinationViewController];
		summaryView.session = mySession;
	
	}
}



@end
