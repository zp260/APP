//
//  WebViewController.m
//  XiRen
//
//  Created by zhuping on 15/4/7.
//  Copyright (c) 2015年 zhuping. All rights reserved.
//

#import "WebViewController.h"
#import "LoginViewController.h"

@interface WebViewController ()
@property (nonatomic) NSDictionary *webHeaderCookieHeader;
@end

@implementation WebViewController
@synthesize url=_url;
@synthesize UserAgent;
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSHTTPCookieStorage *cookiejar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    NSArray *cookieArray = [NSArray arrayWithArray:[cookiejar cookies]];
//    for (id obj in cookieArray) {
//        [cookiejar deleteCookie:obj];
//    }


    
    
    
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"喜人网";
    [self loadUserCookie];
    [self initUI];
    [self whatchCookie];


}
-(void)loadUserCookie
{
    NSData *userCookieData =[[NSUserDefaults standardUserDefaults] objectForKey:@"userdefaultsCookie"];
    if ([userCookieData length]) {
        NSArray *cookies =[NSKeyedUnarchiver unarchiveObjectWithData:userCookieData];
        _webHeaderCookieHeader= [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
        for (NSHTTPCookie *cookie in  cookies) {
           
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
            
        }
    }
    
    
}
-(void)initUI
{
    
    UIBarButtonItem *rightLoginItem = [[UIBarButtonItem alloc]initWithTitle:@"登陆" style:UIBarButtonItemStyleBordered target:self action:@selector(postSubmit)];
    self.navigationItem.rightBarButtonItem = rightLoginItem;
    _webView =[[UIWebView alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
    NSURL *urlstr = [[NSURL alloc]initWithString:self.url];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:urlstr cachePolicy:1 timeoutInterval:30];
    
    [request setHTTPShouldHandleCookies:YES];
    
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
    //获取浏览器头
    UserAgent=[[NSString alloc]initWithString:[_webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"]];
    NSLog(@"webview url  is %@",_url);
    
    
    UIButton *tabButton = [[UIButton alloc]initWithFrame:CGRectMake(0, kDeviceHeight-KTabarHeight, kDeviceWidth, KTabarHeight)];
    [tabButton setTitle:@"登陆" forState:UIControlStateNormal];
    [tabButton setBackgroundColor:[UIColor grayColor]];
    [tabButton addTarget:self action:@selector(whatchCookie) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tabButton];
    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) viewDidDisappear:(BOOL)animated
{
    //[_webView removeFromSuperview];
}
-(void) viewDidAppear:(BOOL)animated
{
    
}

-(void)postSubmit
{
    LoginViewController *loginviewcontrol=[[LoginViewController alloc] init];
    loginviewcontrol.UserAgent = UserAgent;
    [self.navigationController pushViewController:loginviewcontrol animated:YES];
}

-(void)whatchCookie
{
    [_webView reload];
        //NSArray *cookiesALL =[[NSHTTPCookieStorage sharedHTTPCookieStorage]cookies];
    NSArray *xirenCookies =[[NSHTTPCookieStorage sharedHTTPCookieStorage]cookiesForURL:[NSURL URLWithString:@"http://www.xiren.com"]];
    for (NSHTTPCookie *cookie in xirenCookies) {
        if ([cookie.name isEqualToString:@"0d63c_winduser"])
        {
            NSLog(@"%@",cookie);
        }
        NSDictionary *dic = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%@=%@",[cookie name],[cookie value]] forKey:@"Set-Cookie"];
        NSURL *url = [NSURL URLWithString:@"http://www.xiren.com"];
        NSArray *headringCookie = [NSHTTPCookie cookiesWithResponseHeaderFields:dic forURL:url];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookies:headringCookie forURL:url mainDocumentURL:nil];
        
    }
    
    
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
