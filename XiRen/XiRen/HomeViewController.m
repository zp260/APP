//
//  HomeViewController.m
//  XiRen
//
//  Created by zhuping on 15/3/31.
//  Copyright (c) 2015年 zhuping. All rights reserved.
//

#import "HomeViewController.h"


@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize ScroolClickAaary=_ScroolClickAaary;
@synthesize ContentListArray = _ContentListArray;
@synthesize webCrtrol =_webCrtrol;
@synthesize cellImageArray=_cellImageArray;
@synthesize ScroolCount=_ScroolCount;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    //初始化网络要用到的全局变量
    [self data_init];
    //初始化SCROLLVIEW
    [self initScroolView];
    //获得网络接口json数据
    [self getOnlineData];
    //处理数据添加到scroolview
    [self.view addSubview:_FoucsScrool];
    NSLog(@"_ContentListTable  %@", _ContentListTable);

    
 
    
}
-(void)data_init
{
    _ScroolClickAaary = [[NSMutableArray alloc]init];
    _contetList =[[NSArray alloc]init];
    _ContentListArray=[[NSMutableArray alloc]init];
    _cellImageArray = [[NSMutableArray alloc]init];
    _ScroolCount = 0;
    self.pageControl =[[UIPageControl alloc]init];
    self.timer = [[NSTimer alloc]init];
    
}
-(void) initScroolView
{
    
    
    _FoucsScrool=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, ScroolViewHeight+KNavgationBarHeight)];
    [_FoucsScrool setContentSize:CGSizeMake(kDeviceWidth*5, 0)];
    [_FoucsScrool setBackgroundColor:[UIColor grayColor]];
    _FoucsScrool.pagingEnabled=YES;

}

-(void) getOnlineData
{
    [self AFgetOLdata:LunBoAPI_url whichone:@"lunbo"];
    [self AFgetOLdata:ListAPI_url whichone:@"list"];
}

-(void) AFgetOLdata:(NSString *)ApiUrlString whichone:(NSString *)urls
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    [manager GET:ApiUrlString parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
            //传递返回数据
             [self func_back_data:responseObject whichone:urls];
         
         
     }
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         UIAlertView *alert= [[UIAlertView alloc]initWithTitle:@"出错了" message:@"请检查网络" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
         [alert show];
         NSLog(@"json:%@",error);
         
     }];
    
}

//处理返回数据
-(void) func_back_data:(NSMutableArray *)backarray whichone:(NSString *)theclass
{
if([theclass  isEqual: @"list"])
{
    _ContentListArray=backarray;
    //NSLog(@"_ContentListArray %@",_ContentListArray);
    [self cellUIimagevews:_ContentListArray];
    //tableview part。
    [self initContentTableView];
}
NSInteger i=0;
    for (id key in backarray)
        {
            
            //KEY就是传过来的每个轮播数据的数组
            NSArray *arr1 =[[NSArray alloc]initWithObjects:key, nil];
            NSArray *data = [[NSArray alloc]initWithArray:[arr1 valueForKey:@"data"]];
                //{
                //  "data":
                //      {
                //          "url":"http:\/\/www.xiren.com\/11427.html",
                //          "title":"lunbotitle",
                //          "image":"http:\/\/www.xiren.com\/attachment\/pushpic\/20150312091313.jpg"
                //      }
                //}

            
            if ([theclass  isEqual: @"lunbo"])
            {
                //得到每个轮播的url和pic_path
                
                NSArray *PicPath = [[NSArray alloc]initWithArray:[data valueForKey:@"image"]];
                NSArray *picURL = [[NSArray alloc]initWithArray:[data valueForKey:@"url"]];
                NSString *picURLstr=[picURL componentsJoinedByString:@""];
                //NSLog(@"PICPATH数据是%@",PicPath);
                //添加网络图片到scroolview
                [self scrollview_ADD:PicPath ReciveArrNum:i clickURL:picURLstr];
                i++;
            }
        }
}

//异步加载cell用de图片
-(void)cellUIimagevews:(NSMutableArray *)ImageArray
{
    for (id object in  ImageArray) {
        NSLog(@"%@",[[object objectForKey:@"data"] class]);
        NSDictionary *imgDic=[object objectForKey:@"data"];
    

        NSURL *url =[NSURL URLWithString:[imgDic objectForKey:@"image"]];
        UIImage *cellIMG=[UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        [_cellImageArray addObject:cellIMG];
        
    }
}
//添加scrooview元素
-(void) scrollview_ADD:(NSArray*)pic_data ReciveArrNum:(NSInteger)num clickURL:(NSString *)urlstr
{
    UITapGestureRecognizer *singleFingerOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ScroolViewPicClick:)];
    singleFingerOne.numberOfTouchesRequired =1;
    singleFingerOne.numberOfTapsRequired=1;
    singleFingerOne.delegate =self;
    
    
    [_ScroolClickAaary addObject:urlstr];
    NSString *PicUrlString =[pic_data objectAtIndex:0];
    NSURL *url =[NSURL URLWithString:PicUrlString];
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    if([pic_data count])
    {
        UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0+kDeviceWidth*num, 0, kDeviceWidth, ScroolViewHeight)];
        imgview.image=img;
        imgview.userInteractionEnabled=YES;
        imgview.contentMode=UIViewContentModeScaleToFill;
        [imgview addGestureRecognizer:singleFingerOne];
        imgview.tag=num;
        [_FoucsScrool addSubview:imgview];
    }
    
}

//图片点击事件代理
-(void)ScroolViewPicClick:(UITapGestureRecognizer *)sender
{
    
    _webCrtrol= [[WebViewController alloc]init];
    _webCrtrol.url =[_ScroolClickAaary objectAtIndex:sender.view.tag];
    //NSLog(@"data is %@",[_ScroolClickAaary objectAtIndex:sender.view.tag]);
    if (sender.numberOfTapsRequired==1) {
        [self.navigationController pushViewController:_webCrtrol animated:YES];
        [self removeTimer];
    }
    
}

-(void) initContentTableView
{
    UITableView *contentTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-KTabarHeight) style:UITableViewStylePlain];
    [contentTable setDelegate:self];
    [contentTable setDataSource:self];
    [contentTable setTableHeaderView:_FoucsScrool];
    contentTable.scrollEnabled=YES;

    _ContentListTable =contentTable;
    
    _ContentListTable.backgroundColor = [UIColor clearColor];
    _ContentListTable.backgroundView=nil;
    [self.view addSubview:_ContentListTable];
    NSLog(@"_ContentListTable  %@", _ContentListTable);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//TABLEviewdatasouce 代理部分
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *contentListIdentifier= @"XirenContentLIST";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:contentListIdentifier];
    if (cell ==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:contentListIdentifier];
    }
    else{
        //删除cell中的子对象
        while([cell.contentView.subviews lastObject]!=nil){
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
            
            
        }
    }

    NSUInteger row= indexPath.row;
    
    NSDictionary *datadic =[[NSDictionary alloc]initWithDictionary:[[_ContentListArray objectAtIndex:row]objectForKey:@"data"]];
    
    
    UIImage *FaceIMG=[UIImage imageNamed:@"list_head sculpture"];
    UIImageView *FaceImgView = [[UIImageView alloc]initWithFrame:CGRectMake(16,16, 39, 39)];
    FaceImgView.image= FaceIMG;


    UIImageView *cellImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 65, kDeviceWidth-10*2, 150)];
    cellImgView.image=[_cellImageArray objectAtIndex:row];
    [cellImgView setContentMode:UIViewContentModeScaleToFill];
    
    UILabel *ContentLable = [[UILabel alloc]initWithFrame:CGRectMake(70, 30, kDeviceWidth-80, 35)];
    ContentLable.font = [UIFont fontWithName:@"Micro YaHei" size:25];
    ContentLable.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7f];
    ContentLable.text =[datadic objectForKey:@"title"];
    //NSLog(@"ContentLable is %@,cell.lable is %@",ContentLable,cell.textLabel.text);
    
    UILabel *bglable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 30)];
    bglable.backgroundColor=[UIColor colorWithRed:224.0f/255 green:224.0f/255 blue:224.0f/255 alpha:1];
    
    [cell.contentView addSubview:bglable];
    [cell.contentView addSubview:ContentLable];
    [cell.contentView addSubview:cellImgView];
    [cell.contentView addSubview:FaceImgView];
    //[cell.contentView setBackgroundColor:[UIColor colorWithRed:224.0f/255 green:224.0f/255 blue:224.0f/255 alpha:1]];
    //[cell.contentView.subviews
    //cell.imageView.image= cellIMG;
    NSLog(@"cell is %@",cell);
    
    return cell;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Cellheight;
}
////TABLEview 代理部分
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_ContentListArray count];
}
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSUInteger row= indexPath.row;
    NSDictionary *datadic =[[NSDictionary alloc]initWithDictionary:[[_ContentListArray objectAtIndex:row]objectForKey:@"data"]];
    NSLog(@"onjec dic %@",[datadic objectForKey:@"url"]);
    _webCrtrol= [[WebViewController alloc]init];
        _webCrtrol.url=[datadic objectForKey:@"url"];
    NSLog(@"_webCrtrol.url %@",[datadic objectForKey:@"url"]);
    
    [self.navigationController pushViewController:_webCrtrol animated:YES];
    [self removeTimer];
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _FoucsScrool.delegate =self;
    self.pageControl.numberOfPages=5;

        [self addTimer];
}
-(void)nextImage
{
    int i=self.pageControl.currentPage;
    if (i==5-1) {
        i=-1;
    }
    i++;
    [_FoucsScrool setContentOffset:CGPointMake(i*_FoucsScrool.frame.size.width, -KNavgationBarHeight) animated:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
     //    计算页码
     //    页码 = (contentoffset.x + scrollView一半宽度)/scrollView宽度
    self.pageControl.currentPage=(_FoucsScrool.frame.size.width*0.5+_FoucsScrool.contentOffset.x)/_FoucsScrool.frame.size.width;
    NSLog(@"滚动中,%d",self.pageControl.currentPage);
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
     [self removeTimer];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
     [self addTimer];
}
- (void)addTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}
- (void)removeTimer
{
     [self.timer invalidate];
    self.timer=nil;
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
