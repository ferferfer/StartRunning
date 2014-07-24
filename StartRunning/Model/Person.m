//
//  Person.m
//  StartRunning
//
//  Created by Fernando Garcia Corrochano on 14/07/14.
//  Copyright (c) 2014 ironHack. All rights reserved.
//

#import "Person.h"

@implementation Person

- (instancetype)init{
	
	self=[self initWithGender:@"female" andHeight:165 andWeight:55];
	return self;
}

-(id)initWithGender:(NSString *)gender andHeight:(NSInteger)height andWeight:(double)weight{
	self = [super init];
	if (self) {
		_gender=gender;
		_height=height;
		_weight=weight;
	}
	return self;
}

@end
