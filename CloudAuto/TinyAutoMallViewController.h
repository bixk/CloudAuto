//
//  TinyAutoMallViewController.h
//  CloudAuto
//
//  Created by bixk on 14-6-3.
//  Copyright (c) 2014年 tiny-dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TinyAutoMallViewController : UIViewController<UIScrollViewDelegate>
- (IBAction)btnBack:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property BOOL flagShuaxin;
@end
