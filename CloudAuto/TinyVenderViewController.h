//
//  TinyVenderViewController.h
//  CloudAuto
//
//  Created by bixk on 14-6-2.
//  Copyright (c) 2014年 tiny-dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TinyTableViewCell.h"
#import "TinyVenderAction.h"
@class TinyViewController;
@interface TinyVenderViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
- (IBAction)findVenderPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *venderGrid;
@property (nonatomic, strong) UIRefreshControl* refreshControl;
@property (strong, nonatomic) IBOutlet UIButton *btnFindVender;
@property NSMutableArray *venders;
@property TinyViewController *home;
@end
