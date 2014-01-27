//
//  CountrySelectTableViewCell.h
//  HueApp
//
//  Created by Rudi Strahl on 1/26/2014.
//  Copyright (c) 2014 Rudi Strahl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountrySelectTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView            *flagImage;
@property (weak, nonatomic) IBOutlet UILabel                *countryNameLabel;
@property (weak, nonatomic) IBOutlet UILabel                *goldLabel;
@property (weak, nonatomic) IBOutlet UILabel                *silverLabel;
@property (weak, nonatomic) IBOutlet UILabel                *bronzeLabel;

@end
