//
//  MapViewController.h
//  StartRunning
//
//  Created by Fernando Garcia Corrochano on 21/07/14.
//  Copyright (c) 2014 ironHack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SessionHelper.h"
#import "Session.h"

@interface MapViewController : UIViewController

@property(nonatomic,strong)SessionHelper *sessionHelper;
@property(nonatomic,strong)Session *session;

@end
