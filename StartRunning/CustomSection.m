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
	header.backgroundColor=[UIColor appRedColor];
	
	UILabel *run=[[UILabel alloc]initWithFrame:CGRectMake(20, 4, 75, 21)];
	run.text=@"Runned";
	run.font = [UIFont systemFontOfSize:21.0];
	run.textAlignment=NSTextAlignmentCenter;
	
	UILabel *walk=[[UILabel alloc]initWithFrame:CGRectMake(100,4, 75, 21)];
	walk.text=@"Walked";
	walk.font = [UIFont systemFontOfSize:21.0];
	walk.textAlignment=NSTextAlignmentCenter;
	
	UILabel *dateLbl=[[UILabel alloc]initWithFrame:CGRectMake(188,4, 93, 21)];
	dateLbl.text=@"Date";
	dateLbl.font = [UIFont systemFontOfSize:21.0];
	dateLbl.textAlignment=NSTextAlignmentCenter;
	
	[header addSubview:run];
	[header addSubview:walk];
	[header addSubview:dateLbl];
	
	return header;
}

@end
