//
//  TinyAutoMallViewController.m
//  CloudAuto
//
//  Created by bixk on 14-6-3.
//  Copyright (c) 2014年 tiny-dev. All rights reserved.
//

#import "TinyAutoMallViewController.h"

@interface TinyAutoMallViewController ()

@end

@implementation TinyAutoMallViewController
@synthesize flagShuaxin;
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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
}
-(void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset1 = scrollView.contentOffset;
    CGRect bounds1 = scrollView.bounds;
    CGSize size1 = scrollView.contentSize;
    UIEdgeInsets inset1 = scrollView.contentInset;
    float y1 = offset1.y + bounds1.size.height - inset1.bottom;
    float h1 = size1.height;
    float cc=100.0;
    if (y1 > cc) {
        flagShuaxin = YES;
    }
    else if (y1 < cc) {
        flagShuaxin = NO;
    }
    else if (y1 == cc) {
       // DLog(@"%@", flagShuaxin ? @"上拉刷新" : @"下拉刷新");
    }
}
- (IBAction)btnBack:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
@end
