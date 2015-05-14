//
//  RegisterViewController.h
//  XiRen
//
//  Created by PIPI on 15-5-11.
//  Copyright (c) 2015年 zhuping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController
{
    NSString *NickName;
    NSString *password;
    NSString *userEmail;
    
    NSString *postUrlstr;//注册网址
    NSURL *postUrl;//注册网址
    
    NSString *UserAgent;//浏览器头
    
}
@property (nonatomic) NSString *NickName;
@property (nonatomic) NSString *password;
@property (nonatomic) NSString *postUrlstr;
@property (nonatomic) NSURL *postUrl;
@property (strong,nonatomic) UITextField *userInput;
@property (strong,nonatomic) UITextField *PasswordInput;
@property   (strong,nonatomic) UITextField *EmailInput;
@property (nonatomic) NSArray *LoginRequestState;
@property (strong,nonatomic) NSString *UserAgent;

@end
