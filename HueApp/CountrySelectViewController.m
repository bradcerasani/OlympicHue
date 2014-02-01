//
//  CountryViewController.m
//  HueApp
//
//  Created by Rudi Strahl on 1/26/2014.
//  Copyright (c) 2014 Rudi Strahl. All rights reserved.
//

#import "CountrySelectViewController.h"
#import "LeaderboardTableViewCell.h"

@interface CountrySelectViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView        *tableView;
@property (strong, nonatomic) IBOutlet NSMutableArray   *tableData;
@property (weak, nonatomic) IBOutlet UIView             *headerView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem    *doneButton;

@end

static NSString *kCountryTableViewCellIdentifier = @"CountrySelectTableViewCell";

@implementation CountrySelectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableData = [NSMutableArray array];
    NSDictionary *country = [NSDictionary dictionaryWithObjectsAndKeys:
                             @"Canada", @"countryName",
                             @"4", @"goldCount",
                             @"10", @"silverCount",
                             @"2", @"bronzeCount",
                             nil];
    [self.tableData addObject:country];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)didTapDoneButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LeaderboardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCountryTableViewCellIdentifier];
    if (cell == nil)
    {
        cell = [[LeaderboardTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCountryTableViewCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSDictionary *country = (NSDictionary *)[self.tableData objectAtIndex:indexPath.row];
    
    cell.countryNameLabel.text = [country objectForKey:@"countryName"];
    cell.goldLabel.text = [country objectForKey:@"goldCount"];
    cell.silverLabel.text = [country objectForKey:@"silverCount"];
    cell.bronzeLabel.text = [country objectForKey:@"bronzeCount"];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:[country objectForKey:@"imageKey"] ofType:@"png"];
    UIImage *flagImage = [UIImage imageWithContentsOfFile:path];
    if (flagImage)
    {
        cell.flagImage.image = flagImage;
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *country = (NSDictionary *)[self.tableData objectAtIndex:indexPath.row];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:[country objectForKey:@"countryID"] forKey:kSettingsCountry];
    [defaults synchronize];
}

@end
