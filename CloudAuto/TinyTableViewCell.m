//
//  TinyTableViewCell.m
//  CloudAuto
//
//  Created by bixk on 14-6-2.
//  Copyright (c) 2014年 tiny-dev. All rights reserved.
//

#import "TinyTableViewCell.h"

@implementation TinyTableViewCell
@synthesize lblBrand;
@synthesize lblCaption;
@synthesize lblDealCount;
@synthesize lblGoodPercent;
@synthesize lblVender;
@synthesize imgBenefit;
@synthesize imgVIP;
- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
