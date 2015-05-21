//
//  RadioViewController.h
//  XiRen
//
//  Created by zhuping on 15/3/31.
//  Copyright (c) 2015年 zhuping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileVLCKit/MobileVLCKit.h>
#import <XMPP.h>
#import <XMPPRoom.h>
#import <XMPPRoster.h>
#import <XMPPRoomMemoryStorage.h>

@interface RadioViewController : UIViewController<VLCMediaPlayerDelegate,XMPPStreamDelegate,UITableViewDataSource,UITableViewDelegate,XMPPRoomDelegate,XMPPRoomStorage>
{
    VLCMediaPlayer *_mediaplayer;
}
@property (strong,nonatomic)UITableView *ChatMsgTableView;
@property (strong,nonatomic)UITextField *ChatMsgTextFiled;
@property (nonatomic,retain)NSString *chatWhitUser;
@property (nonatomic,strong) XMPPStream *xmppStream;

-(void)sendButton:(id)sender;
-(void)closeButton:(id)sender;
-(void)PlayOrStopCtrol;
@end
