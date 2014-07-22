//
//  IMCcalculator.m
//  StartRunning
//
//  Created by Fernando Garcia Corrochano on 22/07/14.
//  Copyright (c) 2014 ironHack. All rights reserved.
//

#import "IMCcalculator.h"


@implementation IMCcalculator

+(CGFloat)calculateIMCWithWeight:(double)weight andHeight:(NSUInteger)height{

	if (height==0 || weight<=0) {
    return 0;
	}
	CGFloat heightInMeters=height/100.0;
	CGFloat imc=weight/(heightInMeters*heightInMeters);
	
	return imc;
}

@end
