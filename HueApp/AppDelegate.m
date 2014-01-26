//
//  AppDelegate.m
//  HueApp
//
//  Created by Rudi Strahl on 1/24/2014.
//  Copyright (c) 2014 Rudi Strahl. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
#ifdef TESTFLIGHT
    [TestFlight takeOff:@"962d295b-318b-4ba9-af19-47eeaa1b09c3"];
#endif
    
    self.hueController = [[RSHueController alloc] initWithDelegate:self];
    
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
    [self.hueController stopLocalHeartbeat];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [self.hueController startLocalHeartbeat];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - RSHueControllerDelegate

- (void)controllerDidConnectToHueBridge
{
    DLog(@"");
#warning Incomplete Implementation - remove view-overlay enabling usage of app
}

- (void)controllerLostConnectionToHueBridge
{
    DLog(@"");
#warning Incomplete Implementation - display view-overlay preventing usage of app
}

@end
