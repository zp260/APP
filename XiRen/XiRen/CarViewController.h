//
//  HomeViewController.h
//  XiRen
//
//  Created by zhuping on 15/3/31.
//  Copyright (c) 2015年 zhuping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarViewController : UIViewController<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
{
    NSMutableArray *ScroolClickAaary;//存储轮播点击跳转的urls
    NSMutableArray *ContentListArray;//每个cell的数据存储
    NSMutableArray *ScroolImageArray;//网络返回的json数据的轮播数据的存储器
    NSInteger ScroolCount; //返回的轮播josn数据计数
}



@property (strong,nonatomic) UIScrollView *FoucsScrool;
@property (readwrite,nonatomic) NSMutableArray *ScroolClickAaary;

@property (strong,nonatomic) UITableView *ContentListTable;
@property (strong,nonatomic) NSArray *contetList;
@property (strong,nonatomic) NSMutableArray *ContentListArray;
@property (strong,nonatomic) NSMutableArray *cellImageArray;


@property (nonatomic) NSInteger ScroolCount;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic) NSMutableArray *ScroolImageArray;

-(void)xiren_init;

#define LunBoAPI_url @"http://www.xiren.com/api.php?action=lunbo"
#define ListAPI_url @"http://www.xiren.com/api.php?action=listapi"
#define Api_Url @"http://www.xiren.com/androidapi.php?action=car"
#define ScroolViewHeight 180
#define Cellheight  226


@end
