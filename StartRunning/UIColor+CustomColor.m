//
//  UIColor+CustomColor.m
//  StartRunning
//
//  Created by Fernando Garcia Corrochano on 21/07/14.
//  Copyright (c) 2014 ironHack. All rights reserved.
//

#import "UIColor+CustomColor.h"

@implementation UIColor (CustomColor)

+ (UIColor *)appGreenColor
{
		return [UIColor colorWithRed:46 green:204 blue:113];
}

+ (UIColor *)colorWithRed:(NSUInteger)red
                    green:(NSUInteger)green
                     blue:(NSUInteger)blue
{
	return [UIColor colorWithRed:red/255.f green:green/255.f blue:blue/255.f alpha:1.f];
}

@end
