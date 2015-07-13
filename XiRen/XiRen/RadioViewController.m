//
//  RadioViewController.m
//  XiRen
//
//  Created by zhuping on 15/3/31.
//  Copyright (c) 2015年 zhuping. All rights reserved.
//

#import "RadioViewController.h"
#import "ChatTableViewCell.h"
#import "ChatViewController.h"
#import "XirenCoustNav.h"

@interface RadioViewController ()

@property (strong,nonatomic) UIButton *PlayControlBT;

@end

@implementation RadioViewController

@synthesize PlayControlBT;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
    [self initAudio];
    

    
}

-(void)initUI
{
    //自定义NAV BAR 部分
    XirenCoustNav *selfNav = [[XirenCoustNav alloc]init];

    [selfNav initXirenNav:self TitleView:nil WithTitle:@"喜人乐播FM961"];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_video"] style:UIBarButtonItemStylePlain target:self action:@selector(buttonPressed:)];
    rightItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UIBarButtonItem *leftitem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_chat"] style:UIBarButtonItemStylePlain target:self action:@selector(gotoChatRoom)];
    leftitem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftitem;
    
    
    //收听控制播放按钮
    PlayControlBT = [[UIButton alloc]init];
    PlayControlBT=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    PlayControlBT.frame=CGRectMake(kDeviceWidth/2-32, kDeviceHeight-KTabarHeight-128, 64, 64);
    [PlayControlBT addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [PlayControlBT setBackgroundImage:[UIImage imageNamed:@"home_btn_play"] forState:UIControlStateNormal];

    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"home_bg"]]];
    
    [self.view addSubview:PlayControlBT];
    

}
#pragma mark-system delegate
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
-(void)gotoChatRoom
{
    ChatViewController *chatRoomCtrl=[[ChatViewController alloc]init];
    [self.navigationController pushViewController:chatRoomCtrl animated:YES];
}

-(void)keyboardWillHide:(NSNotification *)aNotification
{
    CGRect keyboardRect = [[[aNotification userInfo]objectForKey:UIKeyboardBoundsUserInfoKey]CGRectValue];
    NSTimeInterval animationDuration = [[[aNotification userInfo]objectForKey:UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    CGRect frame = self.view.frame;
    frame.size.height+= keyboardRect.size.height;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame =CGRectMake(0, 0, kDeviceWidth, kDeviceHeight);
    [UIView commitAnimations];
}

#pragma mark-Audio Control
-(void)PlayOrStopCtrol
{
    if ([_mediaplayer isPlaying]) {
        [self pause];
    }
    else {
        [self play];
    }
    NSLog(@"audio state is %hhd",[_mediaplayer isPlaying]);
}


- (void)initAudio
{
    _mediaplayer = [[VLCMediaPlayer alloc] initWithOptions:nil];
    _mediaplayer.delegate = self;
    //    _mediaplayer.drawable = self.movieView;
    
    
    /* create a media object and give it to the player */
    _mediaplayer.media = [VLCMedia mediaWithURL:[NSURL URLWithString:@"mmsh://xiren.tv:20961/fm961"]];
    [_mediaplayer play];
}

- (void)play
{
    if ([_mediaplayer isPlaying])
    {
        return;
    }
    
    [_mediaplayer play];
}

- (void) pause
{
    if (![_mediaplayer isPlaying])
    {
        return;
    }
    
    [_mediaplayer pause];
}

- (void)buttonPressed:(id)sender
{
    if ([_mediaplayer isPlaying]) {
        [self pause];
    }
    else {
        [self play];
    }
}

- (void)updatePlayButton
{
    UIBarButtonItem *rightItem = nil;
    if ([_mediaplayer isPlaying]) {
        rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_video"] style:UIBarButtonItemStylePlain target:self action:@selector(buttonPressed:)];
        [PlayControlBT setBackgroundImage:[UIImage imageNamed:@"home_btn"] forState:UIControlStateNormal];
    }
    else {
        rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Navi_Play"] style:UIBarButtonItemStylePlain target:self action:@selector(buttonPressed:)];
        [PlayControlBT setBackgroundImage:[UIImage imageNamed:@"home_btn_play"] forState:UIControlStateNormal];
    }
    rightItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightItem;
}


#pragma mark - VLC

- (void)mediaPlayerStateChanged:(NSNotification *)aNotification
{
    
    [self updatePlayButton];
}

- (void)mediaPlayerTimeChanged:(NSNotification *)aNotification
{
    
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if ([self.view window] == nil)// 是否是正在使用的视图
    {
        // Add code to preserve data stored in the views that might be
        // needed later.
        
        // Add code to clean up other strong references to the view in
        // the view hierarchy.
        self.view = nil;// 目的是再次进入时能够重新加载调用viewDidLoad函数。
    }
}
@end
