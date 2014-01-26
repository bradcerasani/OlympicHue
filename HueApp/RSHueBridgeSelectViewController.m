//
//  RSHueBridgeSelectViewController.m
//  HueApp
//
//  Created by Rudi Strahl on 1/25/2014.
//  Copyright (c) 2014 Rudi Strahl. All rights reserved.
//

#import "RSHueBridgeSelectViewController.h"

@interface RSHueBridgeSelectViewController ()

@end

@implementation RSHueBridgeSelectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil bridges:(NSDictionary *)bridges delegate:(id<RSHueBridgeSelectViewControllerDelegate>)delegate
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.delegate = delegate;
        self.tableData = bridges;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
