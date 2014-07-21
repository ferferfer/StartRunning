//
//  Route.h
//  StartRunning
//
//  Created by Fernando Garcia Corrochano on 18/07/14.
//  Copyright (c) 2014 ironHack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Route : NSObject

@property(nonatomic,strong)NSMutableArray *arrayOfCoordinates;
@property(nonatomic,strong)NSMutableDictionary *pointCoordinates;

-(void)addPoint:(NSDictionary *)coordinate;
-(id)initWithArrayofCoordinates:(NSArray *)array;
@end
