//
//  TimersManager.m
//  StartRunning
//
//  Created by Fernando Garcia Corrochano on 15/07/14.
//  Copyright (c) 2014 ironHack. All rights reserved.
//

#import "TimersManager.h"

@implementation TimersManager

-(NSUInteger)calculateSeconds:(NSString *)time{
	NSString *mins=[time substringToIndex:2];
	NSString *secs=[time substringFromIndex:3];
	NSUInteger totalSecs=[mins integerValue]*60 + [secs integerValue];
	return totalSecs;
}

-(NSString *)returnTimeFormatWithSeconds:(NSUInteger)seconds{
	NSUInteger mins=seconds/60;
	NSUInteger secs=seconds%60;
	if (mins<10) {
		if (secs<10) {
			return [NSString stringWithFormat:@"0%i:0%i",mins,secs];
		}
		return [NSString stringWithFormat:@"0%i:%i",mins,secs];
	}if (secs<10) {
   	return [NSString stringWithFormat:@"%i:0%i",mins,secs];
	}
	return [NSString stringWithFormat:@"%i:%i",mins,secs];
}

@end
