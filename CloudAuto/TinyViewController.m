//
//  TinyViewController.m
//  CloudAuto
//
//  Created by bixk on 14-6-2.
//  Copyright (c) 2014年 tiny-dev. All rights reserved.
//

#import "TinyViewController.h"

@interface TinyViewController ()

@end

@implementation TinyViewController
@synthesize url;
@synthesize scrVIew;
@synthesize curPage;
@synthesize barImgs;
@synthesize pager;
@synthesize pagernation;
- (void)viewDidLoad
{
    curPage=0;
    [super viewDidLoad];
    self.barImgs = [[NSMutableArray alloc ] init];
    self.url=@"http://localhost:8080/WebBehind/HomePageImages";
    NSURL *mURL= [NSURL URLWithString:self.url];
    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:mURL];
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSLog(@"request send successfully!");
    self.scrVIew.delegate=self;
    self.scrVIew.pagingEnabled=YES;
    NSDictionary *resDic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    self.scrVIew.frame = CGRectMake(0, 0, 320, 200);
   
    NSArray* lst=[resDic objectForKey:@"files"];
    for (int i=0; i<lst.count; i++) {
        NSDictionary *urls=[lst objectAtIndex:i];
        NSString *us=[urls objectForKey:@"url"];
        NSString *host=@"http://localhost:8080";
        NSString*  string ;
        string = [[NSString alloc ]initWithFormat:@"%@%@", host, us ];
        CGRect frame;
        frame.origin.x = self.scrVIew.frame.size.width *(i);
        frame.origin.y = 0;
        frame.size = self.scrVIew.frame.size;
         UIImageView *imageview1=[[UIImageView alloc]initWithFrame:frame];
        
        UIImage *img=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:string]]];
        [imageview1 setImage:img];
        [self.barImgs addObject:img];
        [scrVIew addSubview:imageview1];
       
        //UIView *subView = [[UIView alloc] initWithFrame:frame];
        //subView.backgroundColor = [colors objectAtIndex:i];
        NSLog(string);
        pagernation.numberOfPages=3;
        pagernation.currentPage=0;
        [pagernation addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];
        [scrVIew addSubview:pagernation];
    }
    self.timer=[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    NSLog(@"%d",self.barImgs.count);
    
}
-(void)timerFired:(NSTimer *)timer{
    //NSLog(@"fired...");
    if(self.curPage>=self.barImgs.count)
    {
        self.curPage=0;
    }
    [self.scrVIew setContentOffset:CGPointMake(self.scrVIew.frame.size.width * self.curPage, 0)];
    self.curPage++;
    CGRect frame;
    frame.origin.x = self.scrVIew.frame.size.width *self.curPage+200;
    frame.origin.y = 180;
    [self.pagernation setFrame:frame];
}
-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset=self.scrVIew.contentOffset;
    CGRect bounds=self.scrVIew.frame;
    [pagernation setCurrentPage:offset.x/bounds.size.width];
}
/*
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView1{

}
 */
- (IBAction)findVender:(id)sender {
   
     TinyVenderViewController *controller = [[TinyVenderViewController alloc] initWithNibName:@"TinyVenderViewController" bundle:nil];
    controller.home=self;
    [self presentModalViewController:controller animated:YES];
    //[self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)btnAutoMall:(id)sender {
    TinyAutoMallViewController *mall=[[TinyAutoMallViewController alloc]  initWithNibName:@"TinyAutoMallViewController" bundle:nil];
    [self presentModalViewController:mall animated:YES];
}

- (IBAction)pageTurn:(UIPageControl *)sender {
 
    CGRect frame;
    frame.origin.x = self.scrVIew.frame.size.width * self.pager.currentPage;
    frame.origin.y = 0;
    frame.size = self.scrVIew.frame.size;
 }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)indexChanged:(id)sender {
    [sender currentPage];
}
@end
