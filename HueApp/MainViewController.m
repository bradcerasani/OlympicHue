//
//  ViewController.m
//  HueApp
//
//  Created by Rudi Strahl on 1/24/2014.
//  Copyright (c) 2014 Rudi Strahl. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UIImageView            *backgroundImageView;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
