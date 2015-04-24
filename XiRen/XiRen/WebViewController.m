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
    [self newnavbar];
    // Do any additional setup after loading the view.
    //self.navigationItem.title = @"喜人网";
    _webView =[[UIWebView alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
    NSURL *urlstr = [[NSURL alloc]initWithString:self.url];

    NSURLRequest *request =[[NSURLRequest alloc] initWithURL:urlstr cachePolicy:1 timeoutInterval:30];
        //NSURLRequest *request =[NSURLRequest requestWithURL:urlstr];
    
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
    NSLog(@"Navigation controller is %@",self.navigationController);
    
    

}

-(void) newnavbar
{
    self.navigationController.navigationBar.hidden = NO;
    
    UINavigationBar *customNavigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    UIImageView *navigationBarBackgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_home.png"]];
    [customNavigationBar addSubview:navigationBarBackgroundImageView];
    UINavigationItem *navigationTitle = [[UINavigationItem alloc] initWithTitle:@""];
    [customNavigationBar pushNavigationItem:navigationTitle animated:NO];
    
    
    [self.view addSubview:customNavigationBar];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setBackgroundColor:[UIColor clearColor]];
    backButton.frame = CGRectMake(0, 0, 80, 40);
    [backButton setImage:[UIImage imageNamed:@"tab_set_pre.png"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"tab_set.png"] forState:UIControlStateSelected];
    [backButton addTarget:self action:@selector(backHome) forControlEvents:UIControlEventTouchUpInside];
    //UINavigationItem *navigatorItem = [TTNavigator navigator].visibleViewController.navigationItem;
    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backBarButton;
}
-(void) backHome
{
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) viewDidDisappear:(BOOL)animated
{
    [_webView removeFromSuperview];
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
