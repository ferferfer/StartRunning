//
//  TextFormateer.m
//  StartRunning
//
//  Created by Fernando Garcia Corrochano on 22/07/14.
//  Copyright (c) 2014 ironHack. All rights reserved.
//

#import "TextFormateer.h"

@implementation TextFormateer

+(NSString *)returnCorrectFormatForTextField:(UITextField *)textField{
	NSString *mins;
	NSString *secs;
	NSString *time;
	if (textField.text.length ==4) {
		mins=[textField.text substringToIndex:1];
		secs=[[textField.text substringFromIndex:1] stringByReplacingOccurrencesOfString:@":" withString:@""];
		time=[NSString stringWithFormat:@"0%@:%@",mins,secs ];
	}
	if (textField.text.length<3) {
		//the user cancelled
		if (textField.text.length==0) {
			mins=@"00";
		}
		//The user left the imput this way 1, the logic says that he wants to input 01:00
		if (textField.text.length==1) {
			mins=[NSString stringWithFormat:@"0%@",textField.text];
		}
		//The user left the imput this way 10, the logic says that he wants to input 10:00
		if (textField.text.length==2) {
			mins=textField.text;
		}
		secs=@"00";
		time=[NSString stringWithFormat:@"%@:%@",mins,secs ];
	}
	if (textField.text.length==5) {
    time=textField.text;
	}
	return time;
}

+(BOOL)textFieldIsNillTime:(UITextField *)textField{
	if ([textField.text isEqual:@""] || [textField.text isEqual:@"00:00"] ) {
		return YES;
	}else{
		return NO;
	}
}

+(BOOL)lengthMoreThan:(NSUInteger)lenght ofTextField:(UITextField *)texField andString:(NSString *)string{
	if ((texField.text.length + string.length)>lenght) {
    return YES;
	}else{
		return NO;
	}
}

+(BOOL)shouldAddColonTo:(UITextField *)textField withString:(NSString *)string{
	if(textField.text.length ==2 && ![string isEqualToString:@""]){
		return YES;
	}else{
		return	NO;
	}
}

+(NSString *)addColonTo:(UITextField *)textField{
	return [textField.text stringByAppendingString:@":"];
}

@end
