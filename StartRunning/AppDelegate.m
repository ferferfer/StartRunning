//
//  AppDelegate.m
//  StartRunning
//
//  Created by Fernando Garcia Corrochano on 15/07/14.
//  Copyright (c) 2014 ironHack. All rights reserved.
//

#import "AppDelegate.h"
@import AVFoundation;


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
	CGSize iOSDeviceScreenSize = [[UIScreen mainScreen] bounds].size;
//	AVAudioSession *session = [AVAudioSession sharedInstance];
//	[session setCategory:AVAudioSessionCategoryPlayback error:nil];
	if (iOSDeviceScreenSize.height == 480)
    {
			// Instantiate a new storyboard object using the storyboard file named Storyboard_iPhone35
			UIStoryboard *iPhone35Storyboard = [UIStoryboard storyboardWithName:@"Storyboard35" bundle:nil];
			
			// Instantiate the initial view controller object from the storyboard
			UIViewController *initialViewController = [iPhone35Storyboard instantiateInitialViewController];
			
			// Instantiate a UIWindow object and initialize it with the screen size of the iOS device
			self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
			
			// Set the initial view controller to be the root view controller of the window object
			self.window.rootViewController  = initialViewController;
			
			// Set the window object to be the key window and show it
			[self.window makeKeyAndVisible];
    }
	
	if (iOSDeviceScreenSize.height == 568)
    {   // iPhone 5 and iPod Touch 5th generation: 4 inch screen
			// Instantiate a new storyboard object using the storyboard file named Storyboard_iPhone4
			UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
			
			UIViewController *initialViewController = [mainStoryboard instantiateInitialViewController];
			self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
			self.window.rootViewController  = initialViewController;
			[self.window makeKeyAndVisible];
    }

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
