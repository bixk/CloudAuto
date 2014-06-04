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
@synthesize venders; 
@synthesize curPage;
@synthesize pnlLoading;
@synthesize venderGrid;
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
    curPage=1;
   // self.pnlLoading.hidden=YES;
    [super viewDidLoad];
    UIRefreshControl *rc = [[UIRefreshControl alloc] init];
    rc.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    [rc addTarget:self action:@selector(refreshTableView) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = rc;
    [self.venderGrid addSubview:self.refreshControl];
    
    TinyVenderAction *action=[[TinyVenderAction alloc] init];
    self.venders=[action getVenderList :curPage] ;
    self.venderGrid.delegate=self;
    self.venderGrid.dataSource=self;
    self.scrollView.delegate=self;
    
    ////////////
    UITableViewHeaderFooterView *view = [venderGrid footerViewForSection:0];
    UIView* footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 360, 57.0)];
    UIButton* btnNextPage = [[UIButton alloc] initWithFrame:footerView.frame];
    btnNextPage.titleLabel.text = NSLocalizedString(@"next_page", null);
    [footerView addSubview:btnNextPage];
    [view addSubview:footerView];
}
-(UIView*) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView* footerView;
    if (section ==0) {
      footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 360, 57.0)];
        UIButton* btnNextPage = [[UIButton alloc] initWithFrame:footerView.frame];
        btnNextPage.titleLabel.text = NSLocalizedString(@"next_page", null);
        [footerView addSubview:btnNextPage];
        
    }
    return footerView;
}
-(void) refreshTableView
{
    if (self.refreshControl.refreshing) {
        self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"加载中..."];
        //添加新的模拟数据
        NSDate *date = [[NSDate alloc] init];
        //模拟请求完成之后，回调方法callBackMethod
        [self performSelector:@selector(callBackMethod:) withObject:date afterDelay:1];
    }
}

//这是一个模拟方法，请求完成之后，回调方法
-(void)callBackMethod:(id) obj
{
    [self.refreshControl endRefreshing];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    TinyVenderAction *action=[[TinyVenderAction alloc] init];
    [self.venders removeAllObjects];
    self.venders=[action getVenderList :1] ;
    [self.venderGrid reloadData];
    //
    //    [self.tableView reloadData];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.venders.count;
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndetifier=@"cust";
    TinyTableViewCell *cell=(TinyTableViewCell*) [tableView dequeueReusableCellWithIdentifier:cellIndetifier];
    if(cell==nil)
    {
        NSArray *nib =[[NSBundle mainBundle] loadNibNamed:@"TinyTableViewCell" owner:self options:nil];
        for (id oneObject in nib) {
            if ([oneObject isKindOfClass:[TinyTableViewCell class]]) {
                cell=(TinyTableViewCell*)oneObject;
            }
        }
    }
    NSInteger index=[indexPath row];
    TinyVenderInfo *vender=[self.venders objectAtIndex:index];
    cell.lblVender.text=vender.vender_name;
    cell.lblCaption.text=vender.vender_service_memo;
    NSString *host=@"http://localhost:8080/WebBehind/upload/";
    NSString*  string ;
    string = [[NSString alloc ]initWithFormat:@"%@%@", host, vender.url ];
    UIImage *img=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:string]]];
    
    [cell.headImg setImage:img];
    
    //    cell.lblBrand
    
    return cell;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    pnlLoading.hidden=YES;
    CGPoint offset1 = scrollView.contentOffset;
    CGRect bounds1 = scrollView.bounds;
    CGSize size1 = scrollView.contentSize;
    UIEdgeInsets inset1 = scrollView.contentInset;
    float y1 = offset1.y + bounds1.size.height - inset1.bottom;
    float h1 = size1.height;
    float cc=self.venderGrid.frame.size.height+self.venderGrid.frame.size.height/5;
    if (y1 > cc) {
        flagShuaxin = YES;
        NSLog(@"scroll y1:%f  cc:%f",y1,cc);
        
        TinyVenderAction *action=[[TinyVenderAction alloc] init];
        NSMutableArray *lst= [action getVenderList :curPage+1];
        if(lst!=nil&&lst.count!=0)
        {
            curPage++;
            [self.venders addObjectsFromArray: lst];
            [self.venderGrid reloadData];
        }
      
    }
    else if (y1 < cc) {
        flagShuaxin = NO;

             NSLog(@"下拉");
    }
    else if (y1 == cc) {
        // DLog(@"%@", flagShuaxin ? @"上拉刷新" : @"下拉刷新");
    }
    pnlLoading.hidden=YES;

}
-(void) tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
    
}
-(void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    pnlLoading.hidden=NO;
}
- (IBAction)btnBack:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
@end
