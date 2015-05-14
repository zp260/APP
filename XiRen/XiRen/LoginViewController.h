//
//  LoginViewController.h
//  XiRen
//
//  Created by PIPI on 15-5-4.
//  Copyright (c) 2015年 zhuping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
{
    NSString *name;
    NSString *password;
    NSString *postUrlstr;
    NSURL *postUrl;
    NSString *BrowerUserAgent;
}
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *password;
@property (nonatomic) NSString *postUrlstr;
@property (nonatomic) NSURL *postUrl;
@property (strong,nonatomic) UITextField *userInput;
@property (strong,nonatomic) UITextField *PasswordInput;
@property (nonatomic) NSArray *LoginRequestState;
@property (strong,nonatomic) NSString *BrowerUserAgent;

@end
