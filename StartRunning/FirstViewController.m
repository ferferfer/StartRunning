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

@end

@implementation FirstViewController


-(void)viewDidAppear:(BOOL)animated{
	if (![self.plistManager plistExistInDocumentsFolder]) {
	
		self.genderViewController=[[GenderViewController alloc]init];
		[self performSegueWithIdentifier:@"genderScreenSegue" sender:self];
		
	}else{
		self.mainViewController=[[MainViewController alloc]init];
		[self performSegueWithIdentifier:@"mainScreenSegue" sender:self];
	}

}
//
//-(GenderViewController *)genderViewController{
//	if (_genderViewController) {
//    _genderViewController=[[GenderViewController alloc]init];
//	}
//	return _genderViewController;
//}

- (void)viewDidLoad{
	
	[super viewDidLoad];
		if (![self.plistManager plistExistInDocumentsFolder]) {
	[self loadAlert];
		}

}

-(PlistManager *)plistManager{
	if (_plistManager==nil) {
    _plistManager=[[PlistManager alloc]init];
	}
	return _plistManager;
}

-(void)loadAlert{
	UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Hello!" message:@"It´s your first time here, introduce your profile before continue in order to calculate calories expended." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil ];
	[alert show];
}

#pragma mark - Navigation

//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//
//	if ([[segue identifier] isEqualToString:@"mainScreenSegue"]) {
//		//	MainViewController	*mainView = [segue destinationViewController];
//	}
//	if ([[segue identifier] isEqualToString:@"genderScreenSegue"]) {
//		GenderViewController *genderView = [segue destinationViewController];
//	}
//
//}


@end
