//
//  JSonViewController.m
//  XiRen
//
//  Created by zhuping on 15/3/31.
//  Copyright (c) 2015年 zhuping. All rights reserved.
//

#import "JSonViewController.h"

@interface JSonViewController ()

@end

@implementation JSonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:jsonSourceURLAddress_1];
    NSURLRequest *urlrequest= [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30];
    NSURLConnection *urlConnetction= [NSURLConnection connectionWithRequest:urlrequest delegate:self];
    [urlConnetction start];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSString *str =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"数据是%@",str);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
