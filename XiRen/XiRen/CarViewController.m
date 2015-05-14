//
//  CarViewController.m
//  XiRen
//
//  Created by zhuping on 15/3/31.
//  Copyright (c) 2015年 zhuping. All rights reserved.
//

#import "CarViewController.h"

@interface CarViewController ()

@end

@implementation CarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.navigationController.navigationBarHidden=YES;

    
    // Do any additional setup after loading the view.
    [self newnavbar];
    NSLog(@"CAR Navigation controller is %@",self.navigationController.navigationBar);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) newnavbar
{
   self.navigationController.navigationBar.hidden = YES;
//    
//    UINavigationBar *customNavigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
//    UIImageView *navigationBarBackgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_home.png"]];
//    [customNavigationBar addSubview:navigationBarBackgroundImageView];
//    //UINavigationItem *navigationTitle = [[UINavigationItem alloc] initWithTitle:@"22222"];
////    //[customNavigationBar pushNavigationItem:navigationTitle animated:NO];
//
//    
//    [self.view addSubview:customNavigationBar];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setBackgroundColor:[UIColor clearColor]];
    backButton.frame = CGRectMake(0, 0, 80, 40);
    [backButton setImage:[UIImage imageNamed:@"ico_back.png"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"ico_back_highlighted.png"] forState:UIControlStateSelected];
    [backButton addTarget:self action:@selector(backHome) forControlEvents:UIControlEventTouchUpInside];
    //UINavigationItem *navigatorItem = [TTNavigator navigator].visibleViewController.navigationItem;
    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    UIBarButtonItem *item =[[UIBarButtonItem alloc]initWithTitle:@"sddada" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    [self.navigationItem setRightBarButtonItem:item animated:YES];
    self.navigationItem.leftBarButtonItem = backBarButton;
}
-(void) backHome
{
    NSLog(@"imgood");
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
