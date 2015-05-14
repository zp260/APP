//
//  UserAgent.m
//  XiRen
//
//  Created by PIPI on 15-5-12.
//  Copyright (c) 2015年 zhuping. All rights reserved.
//

#import "UserAgent.h"

@implementation UserAgent

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(NSString *)GetUserAgent
{
    UIWebView *webview= [[UIWebView alloc]init];
    NSString *UserAgent=[[NSString alloc]initWithString:[webview stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"]];
    return UserAgent;
}
@end
