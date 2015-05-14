//
//  CustNavigationBarViewController.m
//  XiRen
//
//  Created by PIPI on 15-5-12.
//  Copyright (c) 2015年 zhuping. All rights reserved.
//

#import "CustNavigationBarViewController.h"

@interface CustNavigationBarViewController ()

@end

@implementation CustNavigationBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(UIView *)NewNavigationBar
{
    UILabel *bar =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, KNavgationBarHeight)];
    [bar setBackgroundColor:[UIColor orangeColor]];
    
    UIButton *NewBarLeftButton =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, KNavgationBarHeight)];
    [NewBarLeftButton setTitle:@"left" forState:UIControlStateNormal];
    [NewBarLeftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *NewBarRightButton =[[UIButton alloc]initWithFrame:CGRectMake(kDeviceWidth-40, 0, 40, KNavgationBarHeight)];
    [NewBarRightButton setTitle:@"right" forState:UIControlStateNormal];
    
    UIImage *BarLableImage =[UIImage imageNamed:@"nav_home"];
    UIImageView *BarLableImageView = [[UIImageView alloc]initWithImage:BarLableImage];
    
    [BarLableImageView addSubview:NewBarRightButton];
    [BarLableImageView addSubview:NewBarLeftButton];
    [bar addSubview:BarLableImageView];
    
    return bar;
}

-(void)leftAction
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
