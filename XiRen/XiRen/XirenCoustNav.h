//
//  XirenCoustNav.h
//  XiRen
//
//  Created by PIPI on 15/6/26.
//  Copyright (c) 2015年 zhuping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XirenCoustNav : UIViewController

-(void)initXirenNav:(UIViewController *)controller TitleView:(UIView *)TitleView WithTitle:(NSString *)title;
-(UIView *)makeNavTitleView:(NSString *)NavTitle;
-(UIColor *)getNavTintColor;
@end
