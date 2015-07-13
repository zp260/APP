//
//  CarViewController.m
//  XiRen
//
//  Created by zhuping on 15/3/31.
//  Copyright (c) 2015年 zhuping. All rights reserved.
//

#import "HomeViewController.h"
#include "XirenCoustNav.h"
#include "CustomCollectionViewCell.h"
#include "CustomPicTalkCollectionViewCell.h"

@interface HomeViewController ()

@property (retain,nonatomic) UICollectionView *ContentCollectionView;
@property (strong,nonatomic) UISegmentedControl *segmentedCtrol;
@end

@implementation HomeViewController

#define ZtableviewX 0
#define ZtableviewY 0 //与navigationbar hight 一样
#define ZscroolviewX 0
#define ZscroolviewY 0
#define ScroolViewHeight 180
#define cellheight 50

@synthesize ContentCollectionView;
@synthesize segmentedCtrol;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initColletion];
    
    // Do any additional setup after loading the view.


    
}
-(void)initColletion
{
    float AD_height =150.0f;
    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.headerReferenceSize = CGSizeMake(kDeviceWidth, AD_height);
    ContentCollectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(0, KNavgationBarHeight+25, kDeviceWidth, kDeviceHeight-KNavgationBarHeight-25*2) collectionViewLayout:flowLayout];
    ContentCollectionView.dataSource=self;
    ContentCollectionView.delegate=self;
    ContentCollectionView.backgroundColor = [UIColor whiteColor];
    
    //注册CELL

    [ContentCollectionView registerClass:[CustomPicTalkCollectionViewCell class] forCellWithReuseIdentifier:@"cell3"];
    [ContentCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
    
    [self.view addSubview:ContentCollectionView];
}
-(void)initUI
{

    
    
    XirenCoustNav *CousterNav = [[XirenCoustNav alloc]init];
    
    //栏目导航
    NSArray *segmentedData = [[NSArray alloc]initWithObjects:@"图说",@"视频", nil];
    segmentedCtrol= [[UISegmentedControl alloc] initWithItems:segmentedData];
    segmentedCtrol.frame = CGRectMake(0, KNavgationBarHeight, kDeviceWidth, 25);
    segmentedCtrol.tintColor = [UIColor clearColor];
    segmentedCtrol.selectedSegmentIndex=0;
    segmentedCtrol.layer.cornerRadius=1;
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:12],NSFontAttributeName,[UIColor grayColor], NSForegroundColorAttributeName, nil];
    [segmentedCtrol setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName: [CousterNav getNavTintColor]};
    [segmentedCtrol setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];//设置文字属性
    
            //设置分段控件点击相应事件
    [segmentedCtrol addTarget:self action:@selector(selected:) forControlEvents:UIControlEventValueChanged];
    
    
    [CousterNav initXirenNav:self TitleView:nil WithTitle:@"喜人网"];
    
    [self.view addSubview:segmentedCtrol];
    
}

#pragma mark-Collection delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 30;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identify=[[NSString alloc]init];
    if (segmentedCtrol.selectedSegmentIndex==0)
    {
        identify = @"cell3";
        

    }
    else
    {
        identify = @"cell";
    }
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell sizeToFit];
    if(!cell)
    {
        NSLog(@"无法创建ColletionCell");
    }
    cell.ImgView.image = [UIImage imageNamed:@"home_bg2"];
    cell.Title.text = @"标题";
    cell.HitCount.text = @"0000";
    cell.ReadNum.text = @"0000";
    return cell;
}
//头部AD区域
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView" forIndexPath:indexPath];
    [headerView addSubview:nil];//这里添加头部自定义广告View
    return headerView;
}

#pragma mark-UicollectionViewDelegateFlowLayout
//定义每个UIcolletionview大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (segmentedCtrol.selectedSegmentIndex == 0)
    {
        return CGSizeMake((kDeviceWidth-20)/3, (kDeviceWidth-20)/3+50);
    }
    else
    {
        return CGSizeMake((kDeviceWidth-20)/2, (kDeviceWidth-20)/2+50);
    }
    
    
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 5, 5, 5);
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}

#pragma mark-Collection Select delegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选择 %ld",(long)indexPath.row);
}

#pragma mark-segement
-(void)selected:(id)sender{
    switch (segmentedCtrol.selectedSegmentIndex) {
        case 0:
            [ContentCollectionView registerClass:[CustomPicTalkCollectionViewCell class] forCellWithReuseIdentifier:@"cell3"];
            break;
        case 1:
            [ContentCollectionView registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
            break;
        default:
            [ContentCollectionView registerClass:[CustomPicTalkCollectionViewCell class] forCellWithReuseIdentifier:@"cell3"];
            break;
    }
    [ContentCollectionView reloadInputViews];
    [ContentCollectionView reloadData];

}

#pragma mark-下载网络数据交互部分
-(void)downLoadApiData:(NSString *)ApiUrlString
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    [manager GET:ApiUrlString parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         //传递返回数据
         
         
         
     }
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         UIAlertView *alert= [[UIAlertView alloc]initWithTitle:@"出错了" message:@"请检查网络" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
         [alert show];
         NSLog(@"json:%@",error);
         
     }];

}
#pragma mark-system delegate
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
