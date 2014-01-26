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

- (void)startLocalHeartbeat;
- (void)stopLocalHeartbeat;

@end
