//
//  ChatViewController.h
//  XiRen
//
//  Created by PIPI on 15/6/17.
//  Copyright (c) 2015年 zhuping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XMPP.h>
#import <XMPPRoom.h>
#import <XMPPRoster.h>
#import <XMPPRoomMemoryStorage.h>

@interface ChatViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,XMPPStreamDelegate,XMPPRoomDelegate,XMPPRoomStorage,UITextViewDelegate,UITextFieldDelegate>

@property (strong,nonatomic)UITableView *ChatMsgTableView;
@property (strong,nonatomic)UITextField *ChatMsgTextFiled;
@property (nonatomic,retain)NSString *chatWhitUser;
@property (nonatomic,strong) XMPPStream *xmppStream;
@property (strong,nonatomic) XMPPMessage *lastChatMessage;
@property (nonatomic) NSString *myname;

@end
