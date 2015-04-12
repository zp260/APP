//
//  HomeViewController.h
//  XiRen
//
//  Created by zhuping on 15/3/31.
//  Copyright (c) 2015年 zhuping. All rights reserved.
//

#import <UIKit/UIKit.h>
#define jsonSourceURLAddress_1 @"http://www.xiren.com/api.php?action=lunbo"
@interface HomeViewController : UIViewController<NSURLConnectionDataDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property (strong,nonatomic) NSMutableData *lookServerResponseData;

@property (readwrite,nonatomic) NSMutableArray *lunboArray;
@property (strong,nonatomic) UIScrollView *FoucsScrool;

@property (strong,nonatomic) UITableView *ContentListTable;
@property (strong,nonatomic) NSArray *contetList;

-(void) scrollview_ADD:(NSArray*)pic_data ReciveArrNum:(NSInteger)num;

@end
