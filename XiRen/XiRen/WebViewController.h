//
//  WebViewController.h
//  XiRen
//
//  Created by zhuping on 15/4/7.
//  Copyright (c) 2015年 zhuping. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WebViewController : UIViewController<UIWebViewDelegate>
{
    NSString *UserAgent;
    UIWebView *XirenWebView;
}
@property (strong,nonatomic)    UIWebView *XirenWebView;
@property (strong,nonatomic)    NSString *url;
@property (nonatomic)           NSString *UserAgent;
@end
