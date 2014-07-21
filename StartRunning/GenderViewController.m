//
//  GenderViewController.m
//  StartRunning
//
//  Created by Fernando Garcia Corrochano on 16/07/14.
//  Copyright (c) 2014 ironHack. All rights reserved.
//

#import "GenderViewController.h"
#import "PlistManager.h"

#define degreesToRadians(x) (M_PI * x / 180.0)

@interface GenderViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *genderPicker;
@property (weak, nonatomic) IBOutlet UITextField *weightTextField;
@property (weak, nonatomic) IBOutlet UITextField *heightTextField;
@property (weak, nonatomic) IBOutlet UIButton *okButton;
@property (weak, nonatomic) IBOutlet UIImageView *arrowView;
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
		self.weightTextField.delegate=self;
		self.person =[self.plistManager	loadProfile];
		[self loadDataFromPerson];
		self.okButton.hidden=YES;
	}


}

-(void)viewDidAppear:(BOOL)animated{
	self.arrowView.layer.anchorPoint = CGPointMake(0.5,1);
	self.arrowView.layer.position=CGPointMake(self.arrowView.center.x + self.arrowView.frame.size.width/2,
																						self.arrowView.center.y + self.arrowView.frame.size.height/2);
	[self moveArrow];
}

-(void)moveArrow{
	
	[UIView animateWithDuration:0.5
												delay:0.0
											options:UIViewAnimationOptionCurveEaseIn
									 animations:^{

										 double imc=[self calculateAngleWithIMC:[self calculateIMC]];
										 self.arrowView.layer.transform = CATransform3DMakeRotation(imc-M_PI_2, 0, 0, 1);
									 }completion:^(BOOL finished){

									 }
	 ];

	
	

	
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

-(void)textFieldDidEndEditing:(UITextField *)textField{
	if([textField.accessibilityLabel isEqualToString:@"weight"]){
		self.person.weight=[textField.text intValue];
	}
	if([textField.accessibilityLabel isEqualToString:@"height"]){
		self.person.height=[textField.text intValue];
	}
	[self moveArrow];
	[self.plistManager updateProfile:self.person];
}


-(CGFloat)calculateIMC{
	Person *person=[[Person alloc]init];
	person=[self.plistManager loadProfile];
	if (person.height==0 || person.weight==0) {
    return 0;
	}
	CGFloat squareHeight=(person.height*person.height)/10000;
	
	CGFloat imc=person.weight/squareHeight;
	
	return imc;
}

-(CGFloat)calculateAngleWithIMC:(double)imc{
	//180 degrees and 24 sections (from 16 to 40) so the operation is:
	return  degreesToRadians(((imc-16)*180)/24);
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
