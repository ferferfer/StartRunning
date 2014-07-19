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
	[self.arrayOfCoordinates addObject:coordinate];
}

- (id)init{
	self = [super init];
	if (self) {
		_pointCoordinates=[[NSMutableDictionary alloc]init];
		_arrayOfCoordinates=[[NSMutableArray alloc]init];
	}
	return self;
}

@end
