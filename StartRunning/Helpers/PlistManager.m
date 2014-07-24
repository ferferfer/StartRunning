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
	[newSession setObject:session.route.arrayOfCoordinates forKey:@"route"];
	
	NSMutableArray *array=[contentArray mutableCopy];
	[array addObject:newSession];
	[array writeToFile:filePath atomically: YES];
	
}

-(Session *)loadSessionWithIndex:(NSInteger)index{
	NSString *path=[self pathOfPlistInDocumentsFolder];
	NSMutableArray *contentArray = [NSArray arrayWithContentsOfFile:path];
	NSMutableDictionary *data=[contentArray objectAtIndex:index];
	NSMutableArray *arrayOfCoordinates= [data objectForKey:@"route"];
	Route *route=[[Route alloc]initWithArrayofCoordinates:arrayOfCoordinates];
	Session *session=[[Session alloc]initWithDate:[data valueForKey:@"sessionDate"]
																andTotalRunning:[[data valueForKey:@"totalRunning"] intValue]
																andTotalWalking:[[data valueForKey:@"totalWalking"] intValue]
																 andTimeRunning:[[data valueForKey:@"timeRunning"] intValue]
																 andTimewalking:[[data valueForKey:@"timeWalking"] intValue]
																		andDistance:[[data valueForKey:@"distance"] doubleValue]
																		 andAvSpeed:[[data valueForKey:@"avSpeed"] doubleValue]
																				andKcal:[[data valueForKey:@"kcal"] doubleValue]
																			 andRoute:route];
	
	return session;
	
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

-(void)updateProfile:(Person *)person{
	
	NSString *filePath=[self pathOfPlistInDocumentsFolder];
	
	NSMutableDictionary *profile=[[NSMutableDictionary alloc]init];
	[profile setObject:person.gender forKey:@"gender"];
	[profile setObject:@(person.height) forKey:@"height"];
	[profile setObject:@(person.weight) forKey:@"weight"];
	
	NSMutableArray *array=[NSArray arrayWithContentsOfFile:filePath];
	[array removeObjectAtIndex:0];
	[array insertObject:profile atIndex:0];
	[array writeToFile:filePath atomically: YES];
	
}

-(NSInteger)numberofSessionsInPlist{
	NSString *path=[self pathOfPlistInDocumentsFolder];
	NSMutableArray *array = [NSArray arrayWithContentsOfFile:path];
	return [array count];
}

-(NSArray *)arrayOfSessions{
	NSString *path=[self pathOfPlistInDocumentsFolder];
	NSMutableArray *array = [NSArray arrayWithContentsOfFile:path];
	NSMutableArray *sessionsArray=[[NSMutableArray alloc]init];
	for(int i=1;i<[array count];i++){
		[sessionsArray addObject:[array objectAtIndex:i]];
	}
	return sessionsArray;
}

-(void)deleteSession:(NSUInteger)index{
	NSMutableArray *sessionsArray=[[self arrayOfSessions] mutableCopy];
	NSMutableArray* auxSessions = sessionsArray.mutableCopy;
	[auxSessions removeObjectAtIndex:(index)];
	Person *person=[[Person alloc]init];
	person=[self loadProfile];
	
	NSMutableDictionary *profile=[[NSMutableDictionary alloc]init];
	[profile setObject:person.gender forKey:@"gender"];
	[profile setObject:@(person.height) forKey:@"height"];
	[profile setObject:@(person.weight) forKey:@"weight"];
	[auxSessions insertObject:profile atIndex:0];
	

	[auxSessions writeToFile:[self pathOfPlistInDocumentsFolder] atomically: YES];
	
}

@end
