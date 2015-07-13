//
//  XirenCoustNav.m
//  XiRen
//
//  Created by PIPI on 15/6/26.
//  Copyright (c) 2015年 zhuping. All rights reserved.
//

#import "XirenCoustNav.h"

@interface XirenCoustNav ()

@end

@implementation XirenCoustNav

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIColor *)getNavTintColor
{
    UIColor *color=[UIColor colorWithRed:251.0f/255.0f green:87.0f/255.0f blue:49.0f/255.0f alpha:1.0f];
    return color;
}
-(UIView *)makeNavTitleView:(NSString *)NavTitle
{
    UILabel *titleView = [[UILabel alloc] init];
    titleView.frame=CGRectMake(0, 0, 150, 25);
    titleView.textColor = [UIColor whiteColor];
    titleView.font = [UIFont yaheiFontOfSize:20];
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.text = NavTitle;
    return titleView;
}
//给withTitle参数的话 titleview无作用  反之 设置titleview
-(void)initXirenNav:(UIViewController *)controller TitleView:(UIView *)TitleView WithTitle:(NSString *)title
{
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1)
    {
        controller.navigationController.navigationBar.tintColor = [UIColor colorWithRed:251.0f/255.0f green:87.0f/255.0f blue:49.0f/255.0f alpha:1.0f];// Load resources for iOS 6.1 or earlier
    }
    else
    {
        controller.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:251.0f/255.0f green:87.0f/255.0f blue:49.0f/255.0f alpha:1.0f];// Load resources for iOS 7 or later
    }
    if (title.length >0) {
        TitleView=[self makeNavTitleView:title];
    }
      controller.navigationItem.titleView = TitleView;
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
