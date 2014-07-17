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
@property	(nonatomic)NSUInteger weight;
@property	(nonatomic)NSUInteger height;

-(id)initWithGender:(NSString *)gender andHeight:(NSInteger)height andWeight:(NSInteger)weight;

@end
