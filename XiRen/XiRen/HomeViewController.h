//
//  HomeViewController.h
//  XiRen
//
//  Created by zhuping on 15/3/31.
//  Copyright (c) 2015年 zhuping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewController.h"
@interface HomeViewController : UIViewController<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>


@property (strong,nonatomic) WebViewController *webCrtrol;
@property (strong,nonatomic) UIScrollView *FoucsScrool;
@property (readwrite,nonatomic) NSMutableArray *ScroolClickAaary; //存储轮播点击跳转的urls

@property (strong,nonatomic) UITableView *ContentListTable;
@property (strong,nonatomic) NSArray *contetList; //TABLE view 储存的标题列表数组
@property (strong,nonatomic) NSMutableArray *ContentListArray;


#define LunBoAPI_url @"http://www.xiren.com/api.php?action=lunbo"
#define ListAPI_url @"http://www.xiren.com/api.php?action=listapi"
#define ScroolViewHeight 200


@end
