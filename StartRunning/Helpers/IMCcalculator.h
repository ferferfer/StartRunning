//
//  IMCcalculator.h
//  StartRunning
//
//  Created by Fernando Garcia Corrochano on 22/07/14.
//  Copyright (c) 2014 ironHack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMCcalculator : NSObject
+(CGFloat)calculateIMCWithWeight:(double)weight andHeight:(NSUInteger)height;

@end
