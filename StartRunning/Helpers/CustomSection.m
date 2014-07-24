//
//  CustomSection.m
//  StartRunning
//
//  Created by Fernando Garcia Corrochano on 22/07/14.
//  Copyright (c) 2014 ironHack. All rights reserved.
//

#import "CustomSection.h"
#import "UIColor+CustomColor.h"

@implementation CustomSection

+(UIView *)sectionStyle{
	UIView *header=[[UIView alloc]init];
	header.backgroundColor=[UIColor whiteColor];
	
	UILabel *run=[[UILabel alloc]initWithFrame:CGRectMake(12, 17, 75, 21)];
	run.text=@"Runned";
	run.font = [UIFont boldSystemFontOfSize:17.0];
	run.textColor =[UIColor appGreenColor];

	UILabel *walk=[[UILabel alloc]initWithFrame:CGRectMake(103,17, 75, 21)];
	walk.text=@"Walked";
	walk.font = [UIFont boldSystemFontOfSize:17.0];
	walk.textColor =[UIColor appGreenColor];
	
	UILabel *dateLbl=[[UILabel alloc]initWithFrame:CGRectMake(215,17, 93, 21)];
	dateLbl.text=@"Date";
	dateLbl.font = [UIFont boldSystemFontOfSize:17.0];
	dateLbl.textColor =[UIColor appGreenColor];

	
	[header addSubview:run];
	[header addSubview:walk];
	[header addSubview:dateLbl];
	
	return header;
}

@end
