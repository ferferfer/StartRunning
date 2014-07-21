//
//  SummaryViewController.h
//  StartRunning
//
//  Created by Fernando Garcia Corrochano on 16/07/14.
//  Copyright (c) 2014 ironHack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Session.h"
#import "Person.h"

@interface SummaryViewController : UIViewController

@property	(nonatomic,strong)Person *person;
@property	(nonatomic,strong)Session	*session;
@property (nonatomic)BOOL navigationBar;

@end
