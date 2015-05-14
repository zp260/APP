//
//  PostSubjectViewController.h
//  XiRen
//
//  Created by PIPI on 15-5-12.
//  Copyright (c) 2015年 zhuping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostSubjectViewController : UIViewController<UITextViewDelegate>
{
    NSString *FID;
    NSString *TID;
    NSString *VerifyCode;
}
@property (nonatomic) NSString *FID;
@property (nonatomic) NSString *TID;
@property (nonatomic) NSString *VerifyCode;
@end
