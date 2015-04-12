//
//  HomeViewController.m
//  XiRen
//
//  Created by zhuping on 15/3/31.
//  Copyright (c) 2015年 zhuping. All rights reserved.
//

#import "HomeViewController.h"
#import "WebViewController.h"

@interface HomeViewController ()
-(void)ScroolViewPicClick:(UITapGestureRecognizer *)sender;
@end

@implementation HomeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //初始化轮播和轮播数据
    [self initScroolView];
    
    //tableview part。
    [self initContentTableView];
    
}

-(void) initScroolView
{
    
    
    //得到轮播json数据FOR ScroolView
    NSURL *url = [NSURL URLWithString:jsonSourceURLAddress_1];
    NSURLRequest *urlrequest= [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
    NSURLConnection *urlConnetction= [NSURLConnection connectionWithRequest:urlrequest delegate:self];
    [urlConnetction start];
    
    _FoucsScrool=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 200)];
    [_FoucsScrool setContentSize:CGSizeMake(kDeviceWidth*5, 0)];
    [_FoucsScrool setBackgroundColor:[UIColor grayColor]];
    _FoucsScrool.pagingEnabled=YES;

}

-(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
   self.lookServerResponseData = [[NSMutableData alloc] init];
}

-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
    [self.lookServerResponseData appendData:data];
 

}
-(void) initContentTableView
{
    NSArray *array = [[NSArray alloc] initWithObjects:@"美国", @"菲律宾",
                      @"黄岩岛", @"中国", @"泰国", @"越南", @"老挝",
                      @"日本" , nil];
    self.contetList = array;

    UITableView *contentTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-49) style:UITableViewStylePlain];
    [contentTable setDelegate:self];
    [contentTable setDataSource:self];
    [contentTable setTableHeaderView:_FoucsScrool];
    contentTable.scrollEnabled=YES;
    //contentTable.contentSize = CGSizeMake(kDeviceWidth, contentTable.SI)
    //contentTable.sizeToFit;
    //[contentTable setDataSource:self];
    _ContentListTable =contentTable;
    
    [self.view addSubview:_ContentListTable];
}
-(void) connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *errorJson=nil;
    NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:self.lookServerResponseData options:kNilOptions error:&errorJson];
    
    
    NSInteger i=0;
    for (id key in responseDict)
    {
        
        //KEY就是传过来的每个轮播数据的数组
        NSArray *arr1 =[[NSArray alloc]initWithObjects:key, nil];
        NSLog(@"KEY数据是%@",arr1);
        //得到每个轮播的url和pic_path
        NSArray *PicUrl = [[NSArray alloc]initWithArray:[arr1 valueForKey:@"data"]];
        NSArray *PicPath = [[NSArray alloc]initWithArray:[PicUrl valueForKey:@"image"]];
        NSLog(@"PICPATH数据是%@",PicPath);
        NSArray *lunbo= [[NSArray alloc]initWithObjects:[[PicPath objectAtIndex:0]copy], nil];
        NSLog(@"datais %@",lunbo);
        [self scrollview_ADD:lunbo ReciveArrNum:i];
        i++;
        //[_lunboArray addObjectsFromArray:lunbo];
        //NSLog(@"pic_path is%@,num is %lu",_lunboArray,(unsigned long)[_lunboArray count]);
    }
    if(errorJson)
    {
        NSLog(@"error:%@",errorJson);
    }
}
//图片点击事件代理
-(void)ScroolViewPicClick:(UITapGestureRecognizer *)sender
{
    WebViewController *webCrtrol= [[WebViewController alloc]init];
    if (sender.numberOfTapsRequired==1) {
        [self.navigationController pushViewController:webCrtrol animated:YES];
    }
   
}
//添加scrooview元素
-(void) scrollview_ADD:(NSArray*)pic_data ReciveArrNum:(NSInteger)num
{
    UITapGestureRecognizer *singleFingerOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ScroolViewPicClick:)];
    singleFingerOne.numberOfTouchesRequired =1;
    singleFingerOne.numberOfTapsRequired=1;
    singleFingerOne.delegate =self;
    NSString *httpstr=@"http://www.xiren.com/";
    NSString *PicUrlString =[pic_data objectAtIndex:0];
    NSString *httpString= [httpstr stringByAppendingString:PicUrlString];
    NSURL *url =[NSURL URLWithString:httpString];
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    if([pic_data count])
    {
        UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0+kDeviceWidth*num, 0, kDeviceWidth, 200)];
        imgview.image=img;
        imgview.userInteractionEnabled=YES;
        imgview.contentMode=UIViewContentModeScaleToFill;
        [imgview addGestureRecognizer:singleFingerOne];
        [_FoucsScrool addSubview:imgview];
    }
    
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
    NSUInteger row= [indexPath row];
    cell.textLabel.text = [self.contetList objectAtIndex:row];
    cell.detailTextLabel.text = @"详细信息";
    return cell;
}

////TABLEview 代理部分
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.contetList count];
}
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
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
