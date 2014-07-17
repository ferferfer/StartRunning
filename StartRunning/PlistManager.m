//
//  PlistManager.m
//  StartRunning
//
//  Created by Fernando Garcia Corrochano on 16/07/14.
//  Copyright (c) 2014 ironHack. All rights reserved.
//

#import "PlistManager.h"

@implementation PlistManager

-(void)addSession:(Session *)session{

	NSString *filePath=[self pathOfPlistInDocumentsFolder];
	
	NSMutableArray *contentArray = [[NSArray arrayWithContentsOfFile:filePath] mutableCopy];
	
	NSMutableDictionary *newSession=[[NSMutableDictionary alloc]init];
	[newSession setValue:session.sessionDate forKey:@"sessionDate"];
	[newSession setValue:@(session.totalWalking) forKey:@"totalWalking"];
	[newSession setValue:@(session.totalRunning) forKey:@"totalRunning"];
	[newSession setValue:@(session.timeWalking) forKey:@"timeWalking"];
	[newSession setValue:@(session.timeRunning) forKey:@"timeRunning"];
	[newSession setValue:@(session.distance) forKey:@"distance"];
	[newSession setValue:@(session.avSpeed) forKey:@"avSpeed"];
	[newSession setValue:@(session.kcal) forKey:@"kcal"];
	[newSession setObject:session.route forKey:@"route"];

	NSMutableArray *array=[contentArray mutableCopy];
	[array addObject:newSession];
	[array writeToFile:filePath atomically: YES];

}

-(void)addProfile:(Person *)person{
	
	NSString *filePath=[self pathOfPlistInDocumentsFolder];
	
	NSMutableDictionary *profile=[[NSMutableDictionary alloc]init];
	[profile setObject:person.gender forKey:@"gender"];
	[profile setObject:@(person.height) forKey:@"height"];
	[profile setObject:@(person.weight) forKey:@"weight"];
	
	NSMutableArray *array=[[NSMutableArray alloc]init];
	[array addObject:profile];
	[array writeToFile:filePath atomically: YES];
	
}


-(BOOL)plistExistInDocumentsFolder{
	NSString *path=[self pathOfPlistInDocumentsFolder];
	NSMutableArray *array = [NSArray arrayWithContentsOfFile:path];
	if (array) {
    return YES;
	}
	return NO;
}

-(NSString *)pathOfPlistInDocumentsFolder{
	NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory=[paths firstObject];
	
	NSString *filePath= [documentsDirectory stringByAppendingPathComponent:@"DataList.plist"];
	return filePath;
}

-(Person *)loadProfile{
	NSString *path=[self pathOfPlistInDocumentsFolder];
	NSMutableArray *contentArray = [NSArray arrayWithContentsOfFile:path];
	NSMutableDictionary *data=[contentArray firstObject];
	Person *person=[[Person alloc]initWithGender:[data valueForKey:@"gender"]
																		 andHeight:[[data valueForKey:@"height"] intValue]
																		 andWeight:[[data valueForKey:@"weight"] intValue]];
	
	return person;
	
}

@end
