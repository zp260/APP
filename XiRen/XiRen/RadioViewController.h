//
//  RadioViewController.h
//  XiRen
//
//  Created by zhuping on 15/3/31.
//  Copyright (c) 2015年 zhuping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileVLCKit/MobileVLCKit.h>
@interface RadioViewController : UIViewController<VLCMediaPlayerDelegate>
{
    VLCMediaPlayer *_mediaplayer;
}
-(void)PlayOrStopCtrol;
@end
