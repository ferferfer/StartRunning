//
//  GenderViewController.m
//  StartRunning
//
//  Created by Fernando Garcia Corrochano on 16/07/14.
//  Copyright (c) 2014 ironHack. All rights reserved.
//

#import "GenderViewController.h"
#import "PlistManager.h"
#import "IMCcalculator.h"

@interface GenderViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *genderController;

@property (weak, nonatomic) IBOutlet UITextField *weightTextField;
@property (weak, nonatomic) IBOutlet UITextField *heightTextField;
@property (weak, nonatomic) IBOutlet UIButton *okButton;
@property (weak, nonatomic) IBOutlet UILabel *imcText;
@property (weak, nonatomic) IBOutlet UITextView *myIMCtext;
@property (weak, nonatomic) IBOutlet UITextView *idealIMCtext;

@property	(nonatomic,strong)NSString *gender;
@property	(nonatomic,strong)PlistManager *plistManager;
@property	(nonatomic,strong)Person *person;



@end

@implementation GenderViewController

- (void)viewDidLoad{
	[super viewDidLoad];
	
	if(![self.plistManager plistExistInDocumentsFolder]){
		self.okButton.hidden=NO;
		self.imcText.hidden=NO;
		self.idealIMCtext.hidden=NO;
	}else{
		self.person =[self.plistManager	loadProfile];
		[self loadDataFromPerson];
		self.okButton.hidden=YES;
	}
	
}
- (IBAction)genderPressed:(id)sender {
	switch (self.genderController.selectedSegmentIndex){
    case 0:
			self.person.gender=@"Male";
      break;
    case 1:
			self.person.gender=@"Female";
      break;
    default:
      break;
  }
	[self.plistManager updateProfile:self.person];
}


-(void)loadDataFromPerson{
	self.weightTextField.text=[NSString stringWithFormat:@"%.1f",self.person.weight];
	self.heightTextField.text=[NSString stringWithFormat:@"%i",self.person.height];
	NSInteger row=[self.person.gender isEqualToString:@"Male"]?0:1;
	[self.genderController setSelectedSegmentIndex:row];
}


-(Person *)person{
	if (_person==nil) {
    _person=[[Person alloc]init];
	}
	return _person;
}

-(PlistManager *)plistManager{
	if (_plistManager==nil) {
    _plistManager=[[PlistManager alloc]init];
	}
	return _plistManager;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	self.person.weight=[self.weightTextField.text intValue];
	self.person.height=[self.heightTextField.text intValue];
	[self.plistManager updateProfile:self.person];
	self.imcText.text=[NSString stringWithFormat:@"%.1f",[self calculateIMC]];
	[self.view endEditing:YES];
}

-(CGFloat)calculateIMC{
	return [IMCcalculator calculateIMCWithWeight:self.person.weight andHeight:self.person.height];

}

- (IBAction)okButtonPressed:(id)sender {
	self.person.gender=@"male";
	self.person.height=[self.heightTextField.text intValue];
	self.person.weight=[self.weightTextField.text intValue];
	[self.plistManager addProfile:self.person];
	[self performSegueWithIdentifier:@"backToMain" sender:self];
	//	[self dismissViewControllerAnimated:YES completion:nil];
}


@end
