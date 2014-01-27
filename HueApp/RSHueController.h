//
//  RSHueController.h
//  HueApp
//
//  Created by Rudi Strahl on 1/25/2014.
//  Copyright (c) 2014 Rudi Strahl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HueSDK_iOS/HueSDK.h>

@protocol RSHueControllerDelegate <NSObject>

- (void)controllerDidConnectToHueBridge;
- (void)controllerLostConnectionToHueBridge;
- (void)controllerDidNotFindBridge;

@end

@interface RSHueController : NSObject

@property (strong, nonatomic) PHHueSDK                                  *hueSDK;
@property (strong, nonatomic) PHBridgeSearching                         *bridgeSearching;
@property (unsafe_unretained, nonatomic) id<RSHueControllerDelegate>    delegate;

- (id)initWithDelegate:(id<RSHueControllerDelegate>)delegate;
/**
 Checks the status of the PHBridgeResourceCache to determine if a configuration exists.
 @return YES if the cache exists and has connected to atleast one IP address, NO otherwise
 */
- (BOOL)hasBridgeConfiguration;

- (void)startLocalHeartbeat;

- (void)stopLocalHeartbeat;

@end
