//
//  LoginViewController.m
//  XiRen
//
//  Created by PIPI on 15-5-4.
//  Copyright (c) 2015年 zhuping. All rights reserved.
//

#import "LoginViewController.h"
#import "MBProgressHUD.h"
@interface LoginViewController ()

@property (strong,nonatomic) MBProgressHUD *hud;

@end

@implementation LoginViewController
@synthesize name;
@synthesize password;
@synthesize postUrl;
@synthesize postUrlstr;
@synthesize userInput;
@synthesize PasswordInput;
@synthesize LoginRequestState;
@synthesize UserAgent;

- (void)viewDidLoad
{
    [super viewDidLoad];
//      登陆状态退出 可用
//    NSHTTPCookieStorage *cookiejar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    NSArray *cookieArray = [NSArray arrayWithArray:[cookiejar cookies]];
//    for (id obj in cookieArray) {
//        [cookiejar deleteCookie:obj];
//    }
    // Do any additional setup after loading the view.
    [self initUI];
    
}

-(void)initUI
{
    postUrlstr = @"http://www.xiren.com/login.php";
    userInput =[[UITextField alloc]initWithFrame:CGRectMake((kDeviceWidth-200)/2, 100, 200, 50)];
    userInput.placeholder = @"请输入用户名";
    [userInput setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [userInput setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    userInput.borderStyle = UITextBorderStyleRoundedRect;
    userInput.clearButtonMode= UITextFieldViewModeAlways;
    
    
    
    PasswordInput = [[UITextField alloc]initWithFrame:CGRectMake((kDeviceWidth-200)/2, 200, 200, 50)];
    PasswordInput.placeholder =@"请输入密码";
    PasswordInput.secureTextEntry = YES;
    [PasswordInput setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [PasswordInput setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    PasswordInput.borderStyle= UITextBorderStyleRoundedRect;
    
    UIButton *submitBT = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    submitBT.frame=CGRectMake((kDeviceWidth-200)/2, 300, 200, 50);
    [submitBT setTitle:@"提交" forState:UIControlStateNormal];
    [submitBT addTarget:self action:@selector(DoPost) forControlEvents:UIControlEventTouchUpInside];
    [submitBT setBackgroundColor:[UIColor grayColor]];
    
    [self.view addSubview:userInput];
    [self.view addSubview:PasswordInput];
    [self.view addSubview:submitBT];
    
    NSString *LoginOK = @"您已经顺利登录";
    NSString *UserNotExist = @"不存在";
    NSString *PasswordWrong = @"用户名或密码错误";
    LoginRequestState = [[NSArray alloc]initWithObjects:LoginOK,UserNotExist,PasswordWrong, nil];

}


-(id)getPostParameters
{
    NSDictionary *pwdic= @{@"pwuser":name,@"pwpwd":password,@"step":@2,@"cktime":@31536000};
    return pwdic;
}
-(void)CheckRequestState:(NSString *)RequestStr
{

    NSRange rangeLogin = [RequestStr rangeOfString:[LoginRequestState objectAtIndex:0]];
    if (rangeLogin.length>0)
    {
        
        NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:@"http://www.xiren.com"]];
        for (NSHTTPCookie *cookie in cookies) {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
        }
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cookies];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"userdefaultsCookie"];

        _hud.mode = MBProgressHUDModeText;
        _hud.labelText = @"登陆成功";
        _hud.removeFromSuperViewOnHide = YES;
        [_hud hide:YES afterDelay:2];
        int index = [[self.navigationController viewControllers]indexOfObject:self];
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:index -1] animated:YES];
        return;

    }
    
    NSRange rangeUserNotExist = [RequestStr rangeOfString:[LoginRequestState objectAtIndex:1]];
    if (rangeUserNotExist.length>0)
    {
        _hud.mode = MBProgressHUDModeText;
        _hud.labelText = @"用户不存在";
        _hud.removeFromSuperViewOnHide = YES;
        [_hud hide:YES afterDelay:2];
        [userInput becomeFirstResponder];
        return;
    }

    NSRange rangePasswordWrong = [RequestStr rangeOfString:[LoginRequestState objectAtIndex:2]];
    if (rangePasswordWrong.length>0)
    {
        _hud.mode = MBProgressHUDModeText;
        _hud.labelText = @"用户密码错误";
        _hud.removeFromSuperViewOnHide = YES;
        [_hud hide:YES afterDelay:2];
        [PasswordInput becomeFirstResponder];
        return;
    }
}
-(void)Checkpassword:(NSDictionary *)paraDic url:(NSString *)url
{
   
    

    //NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSURL *xirenUrl = [[NSURL alloc]initWithString:url];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    
    
    [manager.requestSerializer setValue:UserAgent forHTTPHeaderField:@"User-Agent"];
    //manager.requestSerializer.stringEncoding =enc;
    
    [manager POST:url parameters:paraDic
          success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSString *RequestCookieSetHeader=[[operation.response allHeaderFields] valueForKey:@"Set-Cookie"];
        NSStringEncoding gbkEncoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSString *pageSource = [[NSString alloc] initWithData:responseObject encoding:gbkEncoding];
        [self CheckRequestState:pageSource];
        
        
        
                    NSLog(@"operation is  %@, sucsess data is %@, HTML Body is %@",operation.response.allHeaderFields,[[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies],pageSource);
    }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        NSLog(@"fail data is %@",error);

    }];
}
-(void)DoPost
{
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.labelText = @"发送中...";
    _hud.opacity = 0.5f;
    name=userInput.text;
    password = PasswordInput.text;
    if (name.length ==0)
    {
        _hud.mode = MBProgressHUDModeText;
        _hud.labelText = @"请输入账号";
        _hud.removeFromSuperViewOnHide = YES;
        [_hud hide:YES afterDelay:1];

    }
    else if (password.length == 0 )
    {
        _hud.mode = MBProgressHUDModeText;
        _hud.labelText = @"请输入密码";
        _hud.removeFromSuperViewOnHide = YES;
        [_hud hide:YES afterDelay:1];
    }
    else
    {
        [self Checkpassword:[self getPostParameters] url:postUrlstr];
    }
    
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
