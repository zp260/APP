//
//  AppDelegate.m
//  XiRen
//
//  Created by zhuping on 15/3/31.
//  Copyright (c) 2015年 zhuping. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "RadioViewController.h"
#import "CarViewController.h"
#import "FoodViewController.h"
#import "MeViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //[[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    
    //初始化子视图控制器
    [self ControllerInit];

        return YES;
}
- (void)ControllerInit
{
    HomeViewController *XirenWebCtrol= [[HomeViewController alloc] init];
    RadioViewController *RadioCtrol = [[RadioViewController alloc] init];
    CarViewController *CarCtrol = [[CarViewController alloc] init];
    FoodViewController *foodCtrol=[[FoodViewController alloc] init];
    MeViewController *MeCtrol = [[MeViewController alloc] init];
    
    
    UITabBarItem *Xirenitem = [[UITabBarItem alloc]initWithTitle:@"喜人社区" image:[UIImage imageNamed:@"tab_home.png"] selectedImage:[UIImage imageNamed:@"tab_home_pre.png"]];
    UITabBarItem *RadioItem = [[UITabBarItem alloc]initWithTitle:@"喜人乐播" image:[UIImage imageNamed:@"tab_lebo.png"] selectedImage:[UIImage imageNamed:@"tab_lebo_pre.png"]];
    UITabBarItem *CarItem = [[UITabBarItem alloc]initWithTitle:@"喜人二手车" image:[UIImage imageNamed:@"tab_used car.png"] selectedImage:[UIImage imageNamed:@"tab_used car_pre.png"]];
    UITabBarItem *FoodItem = [[UITabBarItem alloc]initWithTitle:@"喜人商城" image:[UIImage imageNamed:@"tab_shop.png"] selectedImage:[UIImage imageNamed:@"tab_shop_pre.png"]];
    UITabBarItem *MeItem = [[UITabBarItem alloc]initWithTitle:@"设置" image:[UIImage imageNamed:@"tab_set.png"] selectedImage:[UIImage imageNamed:@"tab_set_pre.png"]];


    
    XirenWebCtrol.tabBarItem=Xirenitem;
    RadioCtrol.tabBarItem=RadioItem;
    CarCtrol.tabBarItem=CarItem;
    foodCtrol.tabBarItem=FoodItem;
    MeCtrol.tabBarItem =MeItem;
    
    NSArray *viewcontrollers = @[XirenWebCtrol,RadioCtrol,CarCtrol,foodCtrol,MeCtrol];
    UITabBarController *TabBar=[[UITabBarController alloc] init];
    [TabBar setViewControllers:viewcontrollers animated:YES];
    
    [[UITabBarItem appearance]setTitleTextAttributes:@{UITextAttributeFont:[UIFont systemFontOfSize:12]} forState:UIControlStateNormal];
     [[UITabBarItem appearance]setTitleTextAttributes:@{UITextAttributeFont:[UIFont systemFontOfSize:12],UITextAttributeTextColor:[UIColor colorWithRed:119.0f/255.0f green:136.0f/255.0f blue:153.0f/255.0f alpha:1]} forState:UIControlStateSelected];
    [[UITabBar appearance]setTintColor:[UIColor colorWithRed:119.0f/255.0f green:136.0f/255.0f blue:153.0f alpha:255.0f]];
    
    UINavigationController *navctrol=[[UINavigationController alloc]initWithRootViewController:TabBar];
    
    
    self.window.rootViewController = navctrol;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
