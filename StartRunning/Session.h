//
//  Session.h
//  StartRunning
//
//  Created by Fernando Garcia Corrochano on 14/07/14.
//  Copyright (c) 2014 ironHack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Route.h"

@interface Session : NSObject

@property (nonatomic,strong)NSDate *sessionDate;
@property (nonatomic)NSInteger totalWalking;
@property (nonatomic)NSInteger totalRunning;
@property (nonatomic)NSInteger timeWalking;
@property (nonatomic)NSInteger timeRunning;
@property (nonatomic)NSInteger distance;
@property (nonatomic)NSInteger avSpeed;
@property (nonatomic)NSInteger kcal;
@property (nonatomic,strong)Route *route;


-(id)initWithDate:(NSDate *)date
	andTotalRunning:(NSInteger)totalRunning
	andTotalWalking:(NSInteger)totalWalking
	 andTimeRunning:(NSInteger)timeRunning
	 andTimewalking:(NSInteger)timeWalking
			andDistance:(NSInteger)distance
			 andAvSpeed:(NSInteger)avSpeed
				 andRoute:(Route *)route;




@end
