//
//  RSHueController.m
//  HueApp
//
//  Created by Rudi Strahl on 1/25/2014.
//  Copyright (c) 2014 Rudi Strahl. All rights reserved.
//

#import "RSHueController.h"
#import "RSHueBridgeSelectViewController.h"

@implementation RSHueController

- (id)initWithDelegate:(id<RSHueControllerDelegate>)delegate
{
    if ((self = [super init]))
    {
        self.delegate = delegate;
        [self initHue];
    }
    return self;
}

- (void)initHue
{
    // Set up HueSDK
    self.hueSDK = [[PHHueSDK alloc] init];
    [self.hueSDK startUpSDK];
    
    // Listen for notifications
    PHNotificationManager *hueNotificationManager = [PHNotificationManager defaultManager];
    [hueNotificationManager registerObject:self
                              withSelector:@selector(didReceiveLocalConnectionNotification:)
                           forNotification:LOCAL_CONNECTION_NOTIFICATION];
    [hueNotificationManager registerObject:self
                              withSelector:@selector(didReceiveNoLocalConnectionNotification:)
                           forNotification:NO_LOCAL_CONNECTION_NOTIFICATION];
    [hueNotificationManager registerObject:self
                              withSelector:@selector(didReceiveNoLocalAuthenticationNotification:)
                           forNotification:NO_LOCAL_AUTHENTICATION_NOTIFICATION];
    [hueNotificationManager registerObject:self
                              withSelector:@selector(didReceiveNoLocalBridgeKnownNotification:)
                           forNotification:NO_LOCAL_BRIDGE_KNOWN_NOTIFICATION];
    
    // Set up bridge searching
    self.bridgeSearching = [[PHBridgeSearching alloc] initWithUpnpSearch:YES
                                                         andPortalSearch:YES
                                                       andIpAdressSearch:NO];
    
    [self startLocalHeartbeat];
}

#pragma mark - Bridge Handshake

- (void)startLocalHeartbeat
{
    DLog(@"");
    PHBridgeResourcesCache *cache = [PHBridgeResourcesReader readBridgeResourcesCache];
    if (cache != nil && cache.bridgeConfiguration != nil && cache.bridgeConfiguration.ipaddress != nil)
    {
        [self.hueSDK enableLocalConnectionUsingInterval:10];
    }
    else {
        // No bridge known
        [self searchForBridge];
    }
}

- (void)stopLocalHeartbeat
{
    [self.hueSDK disableLocalConnection];
}

- (void)searchForBridge
{
    DLog(@"");
    // Stop heartbeats
    [self stopLocalHeartbeat];
    
    // Start search via UPnP
    [self.bridgeSearching startSearchWithCompletionHandler:^(NSDictionary *bridgesFound)
    {
        // Check for results
        if (bridgesFound.count > 0)
        {
            NSUInteger index = 0;
            NSArray *sortedKeys = [bridgesFound.allKeys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
            NSString *mac = [sortedKeys objectAtIndex:index];
            NSString *ip = [bridgesFound objectForKey:mac];
            [self setBridgeConfigurationWithIPAddress:ip macAddress:mac];
        }
        else
        {
            [self.delegate controllerDidNotFindBridge];
        }
    }];
}

- (void)setBridgeConfigurationWithIPAddress:(NSString *)ipAddress macAddress:(NSString *)macAddress
{
    // Store the ip/mac/user in the SDK
    [self.hueSDK setBridgeToUseWithIpAddress:ipAddress macAddress:macAddress];
    
    // Re-enable heartbeat so we can track the bridge resources
    [self performSelector:@selector(startLocalHeartbeat) withObject:nil afterDelay:1];
}

- (void)startPushlinkAuthentication
{
    [self stopLocalHeartbeat];
    // Register for notifications about pushlinking
    [self addPushlinkNotifications];
    PHNotificationManager *hueNotificationManager = [PHNotificationManager defaultManager];
    
    [hueNotificationManager registerObject:self
                              withSelector:@selector(didReceivePushlinkAuthenticationSuccessNotification:)
                           forNotification:PUSHLINK_LOCAL_AUTHENTICATION_SUCCESS_NOTIFICATION];
    [hueNotificationManager registerObject:self
                              withSelector:@selector(didReceivePushlinkAuthenticationFailureNotification:)
                           forNotification:PUSHLINK_LOCAL_AUTHENTICATION_FAILED_NOTIFICATION];
    [hueNotificationManager registerObject:self
                              withSelector:@selector(didReceivePushlinkNoLocalConnectionNotification:)
                           forNotification:PUSHLINK_NO_LOCAL_CONNECTION_NOTIFICATION];
    [hueNotificationManager registerObject:self
                              withSelector:@selector(didReceivePushlinkNoLocalBridgeNotification:)
                           forNotification:PUSHLINK_NO_LOCAL_BRIDGE_KNOWN_NOTIFICATION];
    [hueNotificationManager registerObject:self
                              withSelector:@selector(didReceivePushlinkButtonNotPressedNotification:)
                           forNotification:PUSHLINK_BUTTON_NOT_PRESSED_NOTIFICATION];
    [self.hueSDK startPushlinkAuthentication];
}

- (void)addPushlinkNotifications
{
    PHNotificationManager *hueNotificationManager = [PHNotificationManager defaultManager];
    
    [hueNotificationManager registerObject:self
                              withSelector:@selector(didReceivePushlinkAuthenticationSuccessNotification:)
                           forNotification:PUSHLINK_LOCAL_AUTHENTICATION_SUCCESS_NOTIFICATION];
    [hueNotificationManager registerObject:self
                              withSelector:@selector(didReceivePushlinkAuthenticationFailureNotification:)
                           forNotification:PUSHLINK_LOCAL_AUTHENTICATION_FAILED_NOTIFICATION];
    [hueNotificationManager registerObject:self
                              withSelector:@selector(didReceivePushlinkNoLocalConnectionNotification:)
                           forNotification:PUSHLINK_NO_LOCAL_CONNECTION_NOTIFICATION];
    [hueNotificationManager registerObject:self
                              withSelector:@selector(didReceivePushlinkNoLocalBridgeNotification:)
                           forNotification:PUSHLINK_NO_LOCAL_BRIDGE_KNOWN_NOTIFICATION];
    [hueNotificationManager registerObject:self
                              withSelector:@selector(didReceivePushlinkButtonNotPressedNotification:)
                           forNotification:PUSHLINK_BUTTON_NOT_PRESSED_NOTIFICATION];
}

- (void)removePushlinkNotifications
{
    PHNotificationManager *hueNotificationManager = [PHNotificationManager defaultManager];
    [hueNotificationManager deregisterObject:self
                             forNotification:PUSHLINK_LOCAL_AUTHENTICATION_SUCCESS_NOTIFICATION];
    [hueNotificationManager deregisterObject:self
                             forNotification:PUSHLINK_LOCAL_AUTHENTICATION_FAILED_NOTIFICATION];
    [hueNotificationManager deregisterObject:self
                             forNotification:PUSHLINK_NO_LOCAL_CONNECTION_NOTIFICATION];
    [hueNotificationManager deregisterObject:self
                             forNotification:PUSHLINK_NO_LOCAL_BRIDGE_KNOWN_NOTIFICATION];
    [hueNotificationManager deregisterObject:self
                             forNotification:PUSHLINK_BUTTON_NOT_PRESSED_NOTIFICATION];
}

#pragma mark - Hue Notifications

- (void)didReceiveLocalConnectionNotification:(NSNotification *)notification
{
    DLog(@"");
    [self.delegate controllerDidConnectToHueBridge];
}

- (void)didReceiveNoLocalConnectionNotification:(NSNotification *)notification
{
    DLog(@"");
    [self.delegate controllerLostConnectionToHueBridge];
}

- (void)didReceiveNoLocalAuthenticationNotification:(NSNotification *)notification
{
    DLog(@"");
    [self performSelector:@selector(startPushlinkAuthentication) withObject:nil afterDelay:0.5];
}

- (void)didReceiveNoLocalBridgeKnownNotification:(NSNotification *)notification
{
    DLog(@"");
}

- (void)didReceivePushlinkAuthenticationSuccessNotification:(NSNotification *)notification
{
    DLog(@"");
    [self removePushlinkNotifications];
    [self performSelector:@selector(startLocalHeartbeat) withObject:nil afterDelay:1];
}

- (void)didReceivePushlinkAuthenticationFailureNotification:(NSNotification *)notification
{
    DLog(@"");
    [self removePushlinkNotifications];
    [self performSelector:@selector(startLocalHeartbeat) withObject:nil afterDelay:1];
}

/**
 Notification that pushlinking is still being attempted but no button was pressed yet.
 @param notification The notification which contains the pushlinking percentage which has passed.
 */
- (void)didReceivePushlinkButtonNotPressedNotification:(NSNotification *)notification
{
    DLog(@"");
}

/**
 Notification that pushlinking has failed because the local connection to the bridge was lost.
 @param notification
 */
- (void)didReceivePushlinkNoLocalConnectionNotification:(NSNotification *)notification
{
    DLog(@"");
    [self removePushlinkNotifications];
    [self performSelector:@selector(startLocalHeartbeat) withObject:nil afterDelay:1];
}

- (void)didReceivePushlinkNoLocalBridgeNotification:(NSNotification *)notification
{
    DLog(@"");
    [self removePushlinkNotifications];
    [self performSelector:@selector(startLocalHeartbeat) withObject:nil afterDelay:1];
}

@end
