//
//  TinyTableViewCell.h
//  CloudAuto
//
//  Created by bixk on 14-6-2.
//  Copyright (c) 2014年 tiny-dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TinyTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headImg;
@property (strong, nonatomic) IBOutlet UILabel *lblVender;
@property (strong, nonatomic) IBOutlet UILabel *lblGoodPercent;
@property (strong, nonatomic) IBOutlet UILabel *lblCaption;
@property (strong, nonatomic) IBOutlet UILabel *lblBrand;
@property (strong, nonatomic) IBOutlet UILabel *lblDealCount;
@property (strong, nonatomic) IBOutlet UIImageView *imgVIP;
@property (strong, nonatomic) IBOutlet UIImageView *imgBenefit;

@end
