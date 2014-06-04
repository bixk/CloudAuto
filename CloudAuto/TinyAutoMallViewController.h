//
//  TinyAutoMallViewController.h
//  CloudAuto
//
//  Created by bixk on 14-6-3.
//  Copyright (c) 2014年 tiny-dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TinyTableViewCell.h"
#import "TinyVenderAction.h"
@interface TinyAutoMallViewController : UIViewController<UIScrollViewDelegate,UIScrollViewAccessibilityDelegate,UITableViewDataSource,UITableViewDelegate>
- (IBAction)btnBack:(id)sender;
@property NSInteger curPage;
@property NSMutableArray *venders;
@property (nonatomic, strong) UIRefreshControl* refreshControl;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UITableView *venderGrid;
@property BOOL flagShuaxin; 
@property (strong, nonatomic) IBOutlet UIView *pnlLoading;

@end
