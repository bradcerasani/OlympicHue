//
//  AppDelegate.m
//  HueApp
//
//  Created by Rudi Strahl on 1/24/2014.
//  Copyright (c) 2014 Rudi Strahl. All rights reserved.
//

#import "AppDelegate.h"
#import "RSHueController.h"
#import "RSHuePushlinkViewController.h"
#import "MainViewController.h"

@interface AppDelegate() <RSHueControllerDelegate>

@property (strong, nonatomic) RSHueController               *hueController;
@property (strong, nonatomic) RSHuePushlinkViewController   *pushlinkViewController;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
#ifdef TESTFLIGHT
    [TestFlight takeOff:@"962d295b-318b-4ba9-af19-47eeaa1b09c3"];
#endif

//    self.hueController = [[RSHueController alloc] initWithDelegate:self];
    self.pushlinkViewController = [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"PushlinkViewController"];
    
//    if (self.hueController.hasBridgeConfiguration)
//    {
//        self.window.rootViewController = self.pushlinkViewController;
//    }
    
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

#pragma mark - RootViewController Management

- (void)showPushlinkViewController
{
    [self.window setRootViewController:self.pushlinkViewController];
}

- (void)removePushlinkViewController
{

    MainViewController *viewController = [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"MainViewController"];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self.window setRootViewController:navigationController];
}

#pragma mark - RSHueControllerDelegate

- (void)controllerDidConnectToHueBridge
{
    DLog(@"");
    if (self.window.rootViewController == self.pushlinkViewController)
    {
        [self removePushlinkViewController];
    }
//    if (self.pushlinkViewController.view.superview)
//    {
//        [UIView animateWithDuration:1.0f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
//            self.pushlinkViewController.view.alpha = 0.0f;
//        } completion:^(BOOL finished) {
//            [self.pushlinkViewController.view removeFromSuperview];
//        }];
//    }
}

- (void)controllerLostConnectionToHueBridge
{
    DLog(@"");
    if (self.window.rootViewController != self.pushlinkViewController)
    {
        [self showPushlinkViewController];
    }
//    if (!self.pushlinkViewController.view.superview)
//    {
//        [UIView animateWithDuration:1.0f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
//            self.pushlinkViewController.view.alpha = 1.0f;
//        } completion:^(BOOL finished) {
//            [self.window.rootViewController.view addSubview:self.pushlinkViewController.view];
//        }];
//    }
}

- (void)controllerDidNotFindBridge
{
    DLog(@"");
    if (self.window.rootViewController != self.pushlinkViewController)
    {
        [self showPushlinkViewController];
    }
//    if (!self.pushlinkViewController.view.superview)
//    {
//        [UIView animateWithDuration:1.0f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
//            self.pushlinkViewController.view.alpha = 1.0f;
//        } completion:^(BOOL finished) {
//            [self.window.rootViewController.view addSubview:self.pushlinkViewController.view];
//        }];
//    }
}

@end
