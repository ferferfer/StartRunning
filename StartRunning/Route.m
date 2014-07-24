//
//  Route.m
//  StartRunning
//
//  Created by Fernando Garcia Corrochano on 18/07/14.
//  Copyright (c) 2014 ironHack. All rights reserved.
//

#import "Route.h"

@implementation Route

-(void)addPoint:(NSDictionary *)coordinate{
	if (![[self.arrayOfCoordinates lastObject]isEqualToDictionary:coordinate]) {
		[self.arrayOfCoordinates addObject:coordinate];
	}
	
}

- (id)init{
	NSArray *array=[[NSArray alloc]init];
	self = [self initWithArrayofCoordinates:array];
	return self;
}

-(id)initWithArrayofCoordinates:(NSArray *)array{
	self = [super init];
	if (self) {
		_arrayOfCoordinates=[array mutableCopy];
	}
	return self;
}

@end
