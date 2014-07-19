//
//  FirstViewController.m
//  StartRunning
//
//  Created by Fernando Garcia Corrochano on 17/07/14.
//  Copyright (c) 2014 ironHack. All rights reserved.
//

#import "FirstViewController.h"
#import "GenderViewController.h"
#import "PlistManager.h"
#import "MainViewController.h"

@interface FirstViewController ()

@property	(nonatomic,strong)GenderViewController *genderViewController;
@property	(nonatomic,strong)MainViewController *mainViewController;
@property	(nonatomic,strong)PlistManager *plistManager;
@property (weak, nonatomic) IBOutlet UIButton *okButton;
@property (weak, nonatomic) IBOutlet UITextField *helloText;
@property (weak, nonatomic) IBOutlet UITextView *firstText;
@property (weak, nonatomic) IBOutlet UITextView *secondText;

@end

@implementation FirstViewController


-(void)viewDidAppear:(BOOL)animated{
	if ([self.plistManager plistExistInDocumentsFolder]){
		self.mainViewController=[[MainViewController alloc]init];
		[self performSegueWithIdentifier:@"mainScreenSegue" sender:self];
	}
	
}
- (IBAction)okPressed:(id)sender {
	self.genderViewController=[[GenderViewController alloc]init];
	[self performSegueWithIdentifier:@"genderScreenSegue" sender:self];
}

- (void)viewDidLoad{
	
	[super viewDidLoad];
	if (![self.plistManager plistExistInDocumentsFolder]){
		self.helloText.hidden=NO;
		self.firstText.hidden=NO;
		self.secondText.hidden=NO;
		self.okButton.hidden=NO;
	}
}

-(PlistManager *)plistManager{
	if (_plistManager==nil) {
    _plistManager=[[PlistManager alloc]init];
	}
	return _plistManager;
}




@end
