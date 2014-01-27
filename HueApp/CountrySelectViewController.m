//
//  CountryViewController.m
//  HueApp
//
//  Created by Rudi Strahl on 1/26/2014.
//  Copyright (c) 2014 Rudi Strahl. All rights reserved.
//

#import "CountrySelectViewController.h"
#import "CountrySelectTableViewCell.h"

@interface CountrySelectViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView        *tableView;
@property (strong, nonatomic) IBOutlet NSMutableArray   *tableData;
@property (weak, nonatomic) IBOutlet UIView             *headerView;

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
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

#pragma mark - UITableViewDataSource

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return _headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

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
    CountrySelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCountryTableViewCellIdentifier];
    if (cell == nil)
    {
        cell = [[CountrySelectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCountryTableViewCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSDictionary *item = (NSDictionary *)[self.tableData objectAtIndex:indexPath.row];
    
    cell.countryNameLabel.text = [item objectForKey:@"countryName"];
    cell.goldLabel.text = [item objectForKey:@"goldCount"];
    cell.silverLabel.text = [item objectForKey:@"silverCount"];
    cell.bronzeLabel.text = [item objectForKey:@"bronzeCount"];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:[item objectForKey:@"imageKey"] ofType:@"png"];
    UIImage *flagImage = [UIImage imageWithContentsOfFile:path];
    if (!flagImage)
    {
#warning Incomplete Implementation - Detect missing flag image and replace
    }
    cell.flagImage.image = flagImage;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
#warning Incomplete Implementation - return to the mainviewcontroller with the country selected
    
}

@end
