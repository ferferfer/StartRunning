//
//  GPSManager.h
//  StartRunning
//
//  Created by Fernando Garcia Corrochano on 18/07/14.
//  Copyright (c) 2014 ironHack. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GPSManager : NSObject

-(void)startCounter:(BOOL)counterStarted;
@property(nonatomic,strong)NSMutableDictionary *locationDictionary;

@end
