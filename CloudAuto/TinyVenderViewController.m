//
//  TinyVenderViewController.m
//  CloudAuto
//
//  Created by bixk on 14-6-2.
//  Copyright (c) 2014年 tiny-dev. All rights reserved.
//

#import "TinyVenderViewController.h"

@interface TinyVenderViewController ()

@end

@implementation TinyVenderViewController
@synthesize venders;
@synthesize venderGrid;
@synthesize home;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSLog(@"init......");    }
    return self;
}

- (void)viewDidLoad
{
    //初始化UIRefreshControl
    UIRefreshControl *rc = [[UIRefreshControl alloc] init];
    rc.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    [rc addTarget:self action:@selector(refreshTableView) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = rc;
    [self.venderGrid addSubview:self.refreshControl];

    TinyVenderAction *action=[[TinyVenderAction alloc] init];
    self.venders=action.getVenderList ;
    self.venderGrid.delegate=self;
    self.venderGrid.dataSource=self;
    // Do any additional setup after loading the view from its nib.
     [super viewDidLoad];
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
    self.venders=action.getVenderList ;
    [self.venderGrid reloadData];
//    
//    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
- (IBAction)findVenderPressed:(id)sender {
    [self dismissModalViewControllerAnimated:YES];    //home
}
@end
