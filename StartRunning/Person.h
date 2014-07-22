//
//  Person.h
//  StartRunning
//
//  Created by Fernando Garcia Corrochano on 14/07/14.
//  Copyright (c) 2014 ironHack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property	(nonatomic,copy)NSString *gender;
@property	(nonatomic)double weight;//in Kg
@property	(nonatomic)NSUInteger height;//in cm

-(id)initWithGender:(NSString *)gender andHeight:(NSInteger)height andWeight:(double)weight;

@end
