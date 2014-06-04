//
//  TinyViewController.h
//  CloudAuto
//
//  Created by bixk on 14-6-2.
//  Copyright (c) 2014年 tiny-dev. All rights reserved.
//

#import <UIKit/UIKit.h> 
#import "TinyVenderViewController.h"
#import  "TinyAutoMallViewController.h"
@interface TinyViewController : UIViewController<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIPageControl *pager;
- (IBAction)indexChanged:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *scrVIew;
@property (strong, nonatomic) IBOutlet UIPageControl *pagernation;
@property NSMutableArray *barImgs;
@property NSString *url;
@property NSTimer *timer;
@property NSInteger curPage;
@property (strong, nonatomic) IBOutlet UIButton *btnFindVender;
- (IBAction)findVender:(id)sender;
- (IBAction)btnAutoMall:(id)sender;
- (IBAction)pageTurn:(UIPageControl *)sender ;
@end
