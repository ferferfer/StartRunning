//
//  Session.m
//  StartRunning
//
//  Created by Fernando Garcia Corrochano on 14/07/14.
//  Copyright (c) 2014 ironHack. All rights reserved.
//

#import "Session.h"
#import "PlistManager.h"

@implementation Session


- (instancetype)init{
	
	self=[self initWithDate:[NSDate date]
					andTotalRunning:0
					andTotalWalking:0
					 andTimeRunning:0
					 andTimewalking:0
							andDistance:0
							 andAvSpeed:0
									andKcal:0
								 andRoute:nil];
	
	return self;
}

-(id)initWithDate:(NSDate *)date
	andTotalRunning:(NSInteger)totalRunning
	andTotalWalking:(NSInteger)totalWalking
	 andTimeRunning:(NSInteger)timeRunning
	 andTimewalking:(NSInteger)timeWalking
			andDistance:(double)distance
			 andAvSpeed:(double)avSpeed
					andKcal:(double)kcal
				 andRoute:(Route *)route{
	
	self = [super init];
	if (self) {
		_sessionDate=date;
		_totalRunning=totalRunning;
		_totalWalking=totalWalking;
		_timeRunning=timeRunning;
		_timeWalking=timeWalking;
		_distance=distance;
		_avSpeed=avSpeed;
		_kcal=kcal;
		_route=route;
	}
	return self;
}


@end
