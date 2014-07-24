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
	NSInteger mins=seconds/60;
	NSInteger secs=seconds%60;
	if (mins<10) {
		if (secs<10) {
			return [NSString stringWithFormat:@"0%li:0%li",(long)mins,(long)secs];
		}
		return [NSString stringWithFormat:@"0%li:%li",(long)mins,(long)secs];
	}if (secs<10) {
   	return [NSString stringWithFormat:@"%li:0%li",(long)mins,(long)secs];
	}
	return [NSString stringWithFormat:@"%li:%li",(long)mins,(long)secs];
}

@end
