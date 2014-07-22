//
//  TextFormateer.h
//  StartRunning
//
//  Created by Fernando Garcia Corrochano on 22/07/14.
//  Copyright (c) 2014 ironHack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextFormateer : NSObject


+(NSString *)returnCorrectFormatForTextField:(UITextField *)textField;
+(BOOL)textFieldIsNillTime:(UITextField *)textField;
+(BOOL)lengthMoreThan:(NSUInteger)lenght ofTextField:(UITextField *)texField andString:(NSString *)string;
+(BOOL)shouldAddColonTo:(UITextField *)textField withString:(NSString *)string;
+(NSString *)addColonTo:(UITextField *)textField;
@end
