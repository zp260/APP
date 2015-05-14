//
//  RegisterViewController.m
//  XiRen
//
//  Created by PIPI on 15-5-11.
//  Copyright (c) 2015年 zhuping. All rights reserved.
//

#import "RegisterViewController.h"
#import "MBProgressHUD.h"

@interface RegisterViewController ()

@property (strong,nonatomic) MBProgressHUD *hud;

@end

@implementation RegisterViewController

@synthesize NickName;
@synthesize password;
@synthesize postUrl;
@synthesize postUrlstr;
@synthesize userInput;
@synthesize PasswordInput;
@synthesize LoginRequestState;
@synthesize UserAgent;
@synthesize EmailInput;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.


    [self initUI];
}
-(void)initUI
{
    
    postUrlstr = @"http://www.xiren.com/register.php";
    userInput =[[UITextField alloc]initWithFrame:CGRectMake((kDeviceWidth-200)/2, 100, 200, 50)];
    userInput.placeholder = @"昵称";
    [userInput setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [userInput setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    userInput.borderStyle = UITextBorderStyleRoundedRect;
    userInput.clearButtonMode= UITextFieldViewModeAlways;
    
    EmailInput = [[UITextField alloc]initWithFrame:CGRectMake((kDeviceWidth-200)/2, 200, 200, 50)];
    EmailInput.placeholder = @"登陆邮箱";
    EmailInput.borderStyle =UITextBorderStyleRoundedRect;
    [EmailInput setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [EmailInput setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    
    PasswordInput = [[UITextField alloc]initWithFrame:CGRectMake((kDeviceWidth-200)/2, 300, 200, 50)];
    PasswordInput.placeholder =@"请输入密码";
    //PasswordInput.secureTextEntry = YES;
    [PasswordInput setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [PasswordInput setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    PasswordInput.borderStyle= UITextBorderStyleRoundedRect;
    
    
    
    UIButton *submitBT = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    submitBT.frame=CGRectMake((kDeviceWidth-200)/2, 400, 200, 50);
    [submitBT setTitle:@"提交" forState:UIControlStateNormal];
    [submitBT addTarget:self action:@selector(checksubviews) forControlEvents:UIControlEventTouchUpInside];
    [submitBT setBackgroundColor:[UIColor grayColor]];
    
    [self.view addSubview:userInput];
    [self.view addSubview:EmailInput];
    [self.view addSubview:PasswordInput];
    [self.view addSubview:submitBT];
    
    NSString *RegOK = @"<script type=\"text/javascript\">window.location.href";
    NSString *EmailRepeat = @"您的电子邮箱地址有重复";
    NSString *UserRepeat = @"用户名重复";
    NSString *PasswordRuleWrong = @"密码不符合注册规则";
    LoginRequestState = [[NSArray alloc]initWithObjects:RegOK,EmailRepeat,UserRepeat,PasswordRuleWrong,nil];
    
}

-(void)DoPost
{
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.labelText = @"发送中...";
    _hud.opacity = 0.5f;
    NickName=userInput.text;
    password = PasswordInput.text;
    userEmail = EmailInput.text;
    
    if (NickName.length ==0 || NickName.length<5 || NickName.length >40)
    {
        _hud.mode = MBProgressHUDModeText;
        _hud.labelText = @"请输入用户名，并保持用户名长度在5-20个字之间";
        _hud.removeFromSuperViewOnHide = YES;
        [_hud hide:YES afterDelay:2];
        
    }
    else if (userEmail.length==0)
    {
        _hud.mode = MBProgressHUDModeText;
        _hud.labelText = @"请输入Email地址";
        _hud.removeFromSuperViewOnHide = YES;
        [_hud hide:YES afterDelay:2];
        
    }
    else if (![self isValidateEmail:userEmail])
    {
        _hud.mode = MBProgressHUDModeText;
        _hud.labelText = @"请输入正确的Email格式";
        _hud.removeFromSuperViewOnHide = YES;
        [_hud hide:YES afterDelay:2];
    }
    else if (password.length == 0 || password.length <6 || password.length >20)
    {
        _hud.mode = MBProgressHUDModeText;
        _hud.labelText = @"请设置密码,密码长度请保持在6-20位之间";
        _hud.removeFromSuperViewOnHide = YES;
        [_hud hide:YES afterDelay:2];
    }
        else
    {
        [self Post:[self getPostParameters] url:postUrlstr];
    }
    
}
-(NSDictionary *)getPostParameters
{
    NSDictionary *pwdic= @{@"regname":NickName,@"regpwd":password,@"regpwdrepeat":password,@"step":@2,@"regemail":userEmail,@"apartment":@-1,@"rgpermit":@1};
    return pwdic;
}

-(void)CheckRequestState:(NSString *)RequestStr
{
    
    NSRange rangeLogin = [RequestStr rangeOfString:[LoginRequestState objectAtIndex:0]];
    if (rangeLogin.length>0)
    {
        
//        NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:@"http://www.xiren.com"]];
//        for (NSHTTPCookie *cookie in cookies) {
//            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
//        }
//        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cookies];
//        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"userdefaultsCookie"];
        
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
-(void)Post:(NSDictionary *)paraDic url:(NSString *)url
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

-(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest =[NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    return [emailTest evaluateWithObject:email];
}
-(void)checksubviews
{
    NSLog(@"%@",self.tabBarController);
    
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
