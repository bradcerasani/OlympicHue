//
//  AppDelegate.h
//  HueApp
//
//  Created by Rudi Strahl on 1/24/2014.
//  Copyright (c) 2014 Rudi Strahl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSHueController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, RSHueControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) RSHueController *hueController;

@end
