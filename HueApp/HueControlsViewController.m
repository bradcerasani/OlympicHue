//
//  HueControlsViewController.m
//  HueApp
//
//  Created by Rudi Strahl on 2/1/2014.
//  Copyright (c) 2014 Rudi Strahl. All rights reserved.
//

#import "HueControlsViewController.h"

@interface HueControlsViewController ()
- (IBAction)onDoneButtonTap:(id)sender;

@end

@implementation HueControlsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

- (IBAction)onDoneButtonTap:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
