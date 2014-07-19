//
//  GenderViewController.m
//  StartRunning
//
//  Created by Fernando Garcia Corrochano on 16/07/14.
//  Copyright (c) 2014 ironHack. All rights reserved.
//

#import "GenderViewController.h"
#import "PlistManager.h"

@interface GenderViewController ()

@property (weak, nonatomic) IBOutlet UIPickerView *genderPicker;
@property (weak, nonatomic) IBOutlet UITextField *weightTextField;
@property (weak, nonatomic) IBOutlet UITextField *heightTextField;
@property (weak, nonatomic) IBOutlet UIButton *okButton;
@property	(nonatomic,strong)NSString *gender;
@property	(nonatomic,strong)PlistManager *plistManager;
@property	(nonatomic,strong)NSArray *genderArray;
@property	(nonatomic,strong)Person *person;


@end

@implementation GenderViewController

- (void)viewDidLoad{
	[super viewDidLoad];

	if(![self.plistManager plistExistInDocumentsFolder]){
		self.okButton.hidden=NO;
	}else{
		self.person =[self.plistManager	loadProfile];
		[self loadDataFromPerson];
		self.okButton.hidden=YES;
	}

}


-(void)loadDataFromPerson{
	self.weightTextField.text=[NSString stringWithFormat:@"%i",self.person.weight];
	self.heightTextField.text=[NSString stringWithFormat:@"%i",self.person.height];
	NSInteger row=[self.person.gender isEqualToString:@"male"]?0:1;
	[self.genderPicker selectRow:row inComponent:0 animated:YES];
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

-(NSArray *)genderArray{
	if (_genderArray==nil) {
		_genderArray=@[@"Male",@"Female"];
	}
	return _genderArray;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	[self.view endEditing:YES];
}

#pragma mark - Picker View Delegate Methods

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
	return [self.genderArray count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
	
	return [self.genderArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
	if (row==0) {
    self.person.gender=@"Male";
	}else{
    self.person.gender=@"Female";
	}
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
