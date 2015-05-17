//
//  RadioViewController.m
//  XiRen
//
//  Created by zhuping on 15/3/31.
//  Copyright (c) 2015年 zhuping. All rights reserved.
//

#import "RadioViewController.h"


@interface RadioViewController ()

@end

@implementation RadioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //AVAudioSession  *audioSession = [[AVAudioSession sharedInstance]setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    [self initUI];
    [self initAudio];

    
}

-(void)initUI
{
    self.navigationController.navigationBar.backgroundColor=[UIColor grayColor];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Navi_Play"] style:UIBarButtonItemStylePlain target:self action:@selector(buttonPressed:)];
    rightItem.tintColor = [UIColor orangeColor];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 25)];
    titleView.textColor = [UIColor orangeColor];
    titleView.font = [UIFont yaheiFontOfSize:20];
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.text = @"喜人乐播";
    self.navigationItem.titleView = titleView;
    self.navigationItem.title = @"";
    
    
    
}
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
        rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Navi_Pause"] style:UIBarButtonItemStylePlain target:self action:@selector(buttonPressed:)];
    }
    else {
        rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Navi_Play"] style:UIBarButtonItemStylePlain target:self action:@selector(buttonPressed:)];
    }
    rightItem.tintColor = [UIColor grayColor];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
