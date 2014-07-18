//
//  PlistManager.h
//  StartRunning
//
//  Created by Fernando Garcia Corrochano on 16/07/14.
//  Copyright (c) 2014 ironHack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Session.h"
#import "Person.h"
#import "Route.h"

@interface PlistManager : NSObject

-(void)addSession:(Session *)session;
-(BOOL)plistExistInDocumentsFolder;
-(NSString *)pathOfPlistInDocumentsFolder;
-(void)addProfile:(Person *)person;
-(Person *)loadProfile;
@end
