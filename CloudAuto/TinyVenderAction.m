//
//  TinyVenderAction.m
//  CloudAuto
//
//  Created by bixk on 14-6-3.
//  Copyright (c) 2014年 tiny-dev. All rights reserved.
//

#import "TinyVenderAction.h"

@implementation TinyVenderAction
-(NSMutableArray*) getVenderList:(NSInteger) page
{
    NSString *uri= [[NSString alloc] initWithFormat:@"http://localhost:8080/WebBehind/VenderInfoServlet?page=%d" ,page];
    NSString *url=uri;
   // NSLog(uri);
    NSURL *mURL= [NSURL URLWithString:url];
    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:mURL];
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
  //  NSLog(@"request send successfully!");
 
    NSDictionary *resDic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
     NSArray* lst=[resDic objectForKey:@"venders"];
    NSMutableArray *result=[[NSMutableArray alloc] init];
    for(int i=0;i<lst.count;++i)
    {
        NSDictionary *vender_map=[lst objectAtIndex:i];
        TinyVenderInfo *venderInfo= [[TinyVenderInfo alloc] init];
        venderInfo.vender_id=(NSInteger)[vender_map objectForKey:@"venderId"];
        venderInfo.vender_name=(NSString*)[vender_map objectForKey:@"venderName"];
        venderInfo.vender_service_memo=(NSString*)[vender_map objectForKey:@"serviceMemo"];
        venderInfo.url=(NSString*) [vender_map objectForKey:@"shortCutImg"];
        [result addObject:venderInfo];
    }
    return result;
}
@end
