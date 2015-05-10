//
//  WebViewController.h
//  XiRen
//
//  Created by zhuping on 15/4/7.
//  Copyright (c) 2015年 zhuping. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WebViewController : UIViewController
{
    NSString *UserAgent;
}
@property (strong,nonatomic)UIWebView *webView;
@property (strong,nonatomic)NSString *url;
@property (nonatomic) NSString *UserAgent;
@end
