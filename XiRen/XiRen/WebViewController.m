//
//  WebViewController.m
//  XiRen
//
//  Created by zhuping on 15/4/7.
//  Copyright (c) 2015年 zhuping. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"喜人网";
    _webView =[[UIWebView alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.xiren.com"]];
    [self.view addSubview:_webView];
    [_webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
