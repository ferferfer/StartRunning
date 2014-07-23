//
//  UIColor+CustomColor.m
//  StartRunning
//
//  Created by Fernando Garcia Corrochano on 21/07/14.
//  Copyright (c) 2014 ironHack. All rights reserved.
//

#import "UIColor+CustomColor.h"

@implementation UIColor (CustomColor)

+ (UIColor *)appGreenColor{
		return [UIColor colorWithRed:46 green:204 blue:113];
}

+ (UIColor *)appRedColor{
	return [UIColor colorWithRed:231 green:76 blue:60];
}


+ (UIColor *)colorWithRed:(NSUInteger)red
                    green:(NSUInteger)green
                     blue:(NSUInteger)blue{
	return [UIColor colorWithRed:red/255.f green:green/255.f blue:blue/255.f alpha:1.f];
}



+ (UIColor *) navigationMenuGradientTop{
	return [UIColor colorWithRed:213.0f/255.0f green:91.0f/255.0f blue:92.0f/255.0f alpha:1.0f];
}

+ (UIColor *) navigationMenuGradientBottom{
	return [UIColor colorWithRed:188.0f/255.0f green:0.0f/255.0f blue:1.0f/255.0f alpha:1.0f];
}

+ (CAGradientLayer *) navigationMenuGradient{
	NSArray *colors = [NSArray arrayWithObjects:(id)self.appGreenColor, [UIColor whiteColor], nil];
	CAGradientLayer *gradientLayer = [CAGradientLayer layer];
	gradientLayer.colors = colors;
	
	return gradientLayer;
}

@end
