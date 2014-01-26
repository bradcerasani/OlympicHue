//
//  RSHueBridgeSelectViewController.h
//  HueApp
//
//  Created by Rudi Strahl on 1/25/2014.
//  Copyright (c) 2014 Rudi Strahl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RSHueBridgeSelectViewControllerDelegate <NSObject>

/**
 Informs the delegate which bridge was selected.
 @param ipAddress the IP address of the selected bridge
 @param macAddress the MAC address of the selected bridge
 */
- (void)didSelectBridgeWithIPAddress:(NSString *)ipAddress macAddress:(NSString *)macAddress;

/**
 Informs the delegate that the user cancelled bridge selection.
 */
- (void)didCancelBridgeSelection;

@end

@interface RSHueBridgeSelectViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, unsafe_unretained) id<RSHueBridgeSelectViewControllerDelegate>    delegate;
@property (nonatomic, weak) IBOutlet UITableView                                        *tableView;
@property (nonatomic, strong) NSDictionary                                              *tableData;

/**
 Creates a new instance of this bridge selection view controller.
 @param bridges the bridges to show in the list
 @param delegate the delegate to inform when a bridge is selected
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil bridges:(NSDictionary *)bridges delegate:(id<RSHueBridgeSelectViewControllerDelegate>)delegate;

@end

