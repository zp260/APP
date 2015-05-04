//
//  LoginViewController.m
//  XiRen
//
//  Created by PIPI on 15-5-4.
//  Copyright (c) 2015年 zhuping. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize name;
@synthesize password;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(id)getPostParameters
{
    NSString *pwuser= @"pwuser=";
    NSString *pwpwd= @"pwpwd";
    [pwuser stringByAppendingString:name];
    [pwpwd stringByAppendingString:password];
    NSString *setp=@"2";
    NSDictionary *paraDic=[[NSDictionary alloc]initWithObjectsAndKeys:pwuser,pwpwd,setp, nil];
    return paraDic;
}
-(void)Checkpassword:(NSDictionary *)paraDic url:(NSString *)url
{

    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    [manager POST:url parameters:paraDic
    success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"login back str = %@",responseObject);
        
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UIAlertView *alert= [[UIAlertView alloc]initWithTitle:@"出错了" message:@"请检查网络" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];

    }];

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
