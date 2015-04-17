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
@synthesize url=_url;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"喜人网";
    _webView =[[UIWebView alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
    NSURL *urlstr = [[NSURL alloc]initWithString:self.url];
    NSLog(@"webview url %@",urlstr);
    NSURLRequest *request =[[NSURLRequest alloc] initWithURL:urlstr cachePolicy:1 timeoutInterval:30];
    NSLog(@"webview request %@",request);
    //NSURLRequest *request =[NSURLRequest requestWithURL:urlstr];
    
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
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
