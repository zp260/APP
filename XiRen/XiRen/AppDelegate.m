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
#import "LoginViewController.h"
#import "RegisterViewController.h"

@interface AppDelegate ()
@property (strong,nonatomic) RadioViewController *RadioCtrol;
@end

@implementation AppDelegate
@synthesize RadioCtrol;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    
    //初始化子视图控制器
    [self ControllerInit];

        return YES;
}
- (void)ControllerInit
{
    
    CarViewController *XirenWebCtrol= [[CarViewController alloc] init];
    RadioCtrol = [[RadioViewController alloc] init];
    HomeViewController *CarCtrol = [[HomeViewController alloc] init];
    FoodViewController *foodCtrol=[[FoodViewController alloc] init];
    MeViewController *MeCtrol = [[MeViewController alloc] init];

    
    
    UITabBarItem *Xirenitem = [[UITabBarItem alloc]initWithTitle:@"喜人汽车" image:[UIImage imageNamed:@"face"] selectedImage:[UIImage imageNamed:@"face"]];
    UITabBarItem *RadioItem = [[UITabBarItem alloc]initWithTitle:@"FM961" image:[UIImage imageNamed:@"tab_fm961.png"] selectedImage:[UIImage imageNamed:@"tab_fm961.png"]];
    UITabBarItem *CarItem = [[UITabBarItem alloc]initWithTitle:@"喜人社区" image:[UIImage imageNamed:@"car"] selectedImage:[UIImage imageNamed:@"car"]];
    UITabBarItem *FoodItem = [[UITabBarItem alloc]initWithTitle:@"喜人活动" image:[UIImage imageNamed:@"tab_activity"] selectedImage:[UIImage imageNamed:@"tab_activity"]];
    UITabBarItem *MeItem = [[UITabBarItem alloc]initWithTitle:@"我" image:[UIImage imageNamed:@"tab_me.png"] selectedImage:[UIImage imageNamed:@"tab_me.png"]];

    

    
    XirenWebCtrol.tabBarItem=Xirenitem;
    RadioCtrol.tabBarItem=RadioItem;
    CarCtrol.tabBarItem=CarItem;
    foodCtrol.tabBarItem=FoodItem;
    MeCtrol.tabBarItem =MeItem;
    
    UINavigationController *XirenWebNavctrol=[[UINavigationController alloc]initWithRootViewController:XirenWebCtrol];
    UINavigationController *RadioNavCtrol=[[UINavigationController alloc]initWithRootViewController:RadioCtrol];
    UINavigationController *CarNavCtrol=[[UINavigationController alloc]initWithRootViewController:CarCtrol];
    
    
    NSArray *viewcontrollers = @[RadioNavCtrol,CarNavCtrol,XirenWebNavctrol,foodCtrol,MeCtrol];
    
    
    UITabBarController *TabBar=[[UITabBarController alloc] init];
    [TabBar setViewControllers:viewcontrollers animated:YES];
    
    [[UITabBarItem appearance]setTitleTextAttributes:@{UITextAttributeFont:[UIFont systemFontOfSize:12]} forState:UIControlStateNormal];
     [[UITabBarItem appearance]setTitleTextAttributes:@{UITextAttributeFont:[UIFont systemFontOfSize:12],UITextAttributeTextColor:[UIColor colorWithRed:251.0f/255.0f green:87.0f/255.0f blue:49.0f/255.0f alpha:1]} forState:UIControlStateSelected];
    [[UITabBar appearance]setTintColor:[UIColor colorWithRed:251.0f/255.0f green:87.0f/255.0f blue:49.0f/255.0f alpha:1.0f]];

    self.window.rootViewController = TabBar;
    self.window.backgroundColor = [UIColor whiteColor];
    
    //[XirenWebCtrol xiren_init];//初始化喜人网网络数据
    
    [self.window makeKeyAndVisible];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {

    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[UIApplication sharedApplication]beginBackgroundTaskWithExpirationHandler:nil];
    [self becomeFirstResponder];
    
    

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[UIApplication  sharedApplication] endReceivingRemoteControlEvents];
    [self resignFirstResponder];
}
-(void)remoteControlReceivedWithEvent:(UIEvent *)event{
    if (event.type ==UIEventTypeRemoteControl) {
        switch (event.subtype) {
            case UIEventSubtypeRemoteControlTogglePlayPause:
                
                [RadioCtrol PlayOrStopCtrol];
                break;
             case UIEventSubtypeRemoteControlPlay:
                [RadioCtrol PlayOrStopCtrol];
                break;
                case UIEventSubtypeRemoteControlPause:
                [RadioCtrol PlayOrStopCtrol];
                break;
            default:
                break;
        }
    }
}
-(BOOL)canBecomeFirstResponder
{
    return YES;
}

@end
