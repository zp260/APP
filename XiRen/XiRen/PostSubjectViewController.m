//
//  PostSubjectViewController.m
//  XiRen
//
//  Created by PIPI on 15-5-12.
//  Copyright (c) 2015年 zhuping. All rights reserved.
//

#import "PostSubjectViewController.h"
#import "UserAgent.h"
#import "LoginViewController.h"
#import "MBProgressHUD.h"
@interface PostSubjectViewController ()

@property (nonatomic) NSString *BrowerUserAgent;
@end

@implementation PostSubjectViewController

@synthesize BrowerUserAgent;
@synthesize FID;
@synthesize TID;
@synthesize VerifyCode;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)initUI
{
    UserAgent *Agent = [[UserAgent alloc]init];
    BrowerUserAgent = [Agent GetUserAgent];
    
    UITextView *ContentTextFiled = [[UITextView alloc]initWithFrame:CGRectMake(20, KNavgationBarHeight+40, kDeviceWidth-40, 100)];
    ContentTextFiled.layer.cornerRadius =6;
    ContentTextFiled.layer.masksToBounds =YES;
    ContentTextFiled.layer.borderWidth=1.0;
    ContentTextFiled.delegate = self;

    
    UIBarButtonItem *rightLoginItem = [[UIBarButtonItem alloc]initWithTitle:@"发表" style:UIBarButtonItemStyleBordered target:self action:@selector(postSubmit)];
    self.navigationItem.rightBarButtonItem = rightLoginItem;
    self.navigationItem.title = @"回帖";
    
    
    [self.view addSubview:ContentTextFiled];
    
}

//生成发帖参数
-(id)GiveUSomeParameters
{
    //@verify is a importent parameter
    NSDictionary *pwdic= @{@"action":@"reply",@"fid":FID,@"step":@2,@"tid":TID,@"ajax":@1,@"atc_content":@"",@"atc_convert":@2,@"verify":VerifyCode};
    return pwdic;
}

-(void)Dopost:(NSDictionary *)paraDic url:(NSString *)url
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    [manager.requestSerializer setValue:BrowerUserAgent forHTTPHeaderField:@"User-Agent"];

    
    [manager POST:url parameters:paraDic
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         
         NSStringEncoding gbkEncoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
         NSString *pageSource = [[NSString alloc] initWithData:responseObject encoding:gbkEncoding];
         
         
         
         
         NSLog(@"operation is  %@, sucsess data is %@, HTML Body is %@",operation.response.allHeaderFields,[[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies],pageSource);
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"fail data is %@",error);
         
     }];
}

-(void)postSubmit
{
    
}
-(void)textViewDidChangeSelection:(UITextView *)textView
{

    
}

-(BOOL)DoULogined
{
    NSData *userCookieData =[[NSUserDefaults standardUserDefaults] objectForKey:@"userdefaultsCookie"];
    if ([userCookieData length])
    {
        NSArray *cookies =[NSKeyedUnarchiver unarchiveObjectWithData:userCookieData];
        
        for (NSHTTPCookie *cookie in  cookies)
        {
            
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
            
        }
        return TRUE;
    }
    else
    {
        return FALSE;
    }
    
}

//在载入VIEW的时候判断是否登陆，没有登陆跳转到登陆界面
-(void)viewDidAppear:(BOOL)animated
{
 

    
    if ([self DoULogined])
    {
        [self initUI];
    }
    else
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.opacity = 0.5f;
        hud.labelText = @"您尚未登陆，即将跳转到登陆界面。";
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:2];
        
        //延迟两秒跳转
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(GOtoLoginCtroller) userInfo:nil repeats:NO];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        
       
    }

}
//跳转到登陆界面
-(void)GOtoLoginCtroller
{
    LoginViewController *loginCtrol=[[LoginViewController alloc]init];
    [self.navigationController pushViewController:loginCtrol animated:YES];
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
