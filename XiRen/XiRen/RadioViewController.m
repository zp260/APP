//
//  RadioViewController.m
//  XiRen
//
//  Created by zhuping on 15/3/31.
//  Copyright (c) 2015年 zhuping. All rights reserved.
//

#import "RadioViewController.h"


@interface RadioViewController ()

@property (strong,nonatomic) NSMutableArray *roster;
@property (retain,nonatomic) UITextField *xmppUserTF;
@property (retain,nonatomic) UITextField *xmppPassTF;
@property (retain,nonatomic) UITextField *xmppServerTF;
@property (strong,nonatomic) XMPPRoom *xmppRoomXiren;
@property (strong,nonatomic) XMPPJID *RoomJID;


@end

@implementation RadioViewController

@synthesize xmppStream;
@synthesize roster;
@synthesize xmppPassTF;
@synthesize xmppServerTF;
@synthesize xmppUserTF;
@synthesize xmppRoomXiren;
@synthesize RoomJID;

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
    
    UIButton *chatSenButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    chatSenButton.frame =CGRectMake(20, 100, 100, 50);
    [chatSenButton addTarget:self action:@selector(queryRoster) forControlEvents:UIControlEventTouchUpInside];
    [chatSenButton setTitle:@"查看好友列表" forState: UIControlStateNormal];
    [self.view addSubview:chatSenButton];
    
    xmppUserTF =[[UITextField alloc]initWithFrame:CGRectMake(100, 200, 200, 30)];
    xmppUserTF.placeholder = @"用户名";
    xmppUserTF.borderStyle = UITextBorderStyleBezel;
    xmppUserTF.clearButtonMode = UITextFieldViewModeAlways;
    
    xmppPassTF = [[UITextField alloc]initWithFrame:CGRectMake(100, 240, 200, 30)];
    xmppPassTF.placeholder = @"密码";
    xmppPassTF.borderStyle=UITextBorderStyleBezel;
    xmppPassTF.clearButtonMode = UITextFieldViewModeAlways;
    
    xmppServerTF = [[UITextField alloc]initWithFrame:CGRectMake(100, 280, 200, 30)];
    xmppServerTF.placeholder=@"服务器";
    xmppServerTF.borderStyle =UITextBorderStyleBezel;
    xmppServerTF.clearButtonMode = UITextFieldViewModeAlways;
    xmppServerTF.text = @"192.168.1.12";
    
    UIButton *xmppLoginAndConnectBT=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    xmppLoginAndConnectBT.frame =CGRectMake(100, 320, 200, 30);
    [xmppLoginAndConnectBT addTarget:self action:@selector(otherconnect) forControlEvents:UIControlEventTouchUpInside];
    [xmppLoginAndConnectBT setTitle:@"连接并登陆服务器" forState:UIControlStateNormal];
    
    UIButton *xmppRoomLoginBT=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    xmppRoomLoginBT.frame =CGRectMake(100, 360, 200, 30);
    [xmppRoomLoginBT addTarget:self action:@selector(initXmppRoom) forControlEvents:UIControlEventTouchUpInside];
    [xmppRoomLoginBT setTitle:@"进入房间" forState:UIControlStateNormal];
    
    UIButton *RoomSendMessageBT=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    RoomSendMessageBT.frame =CGRectMake(100, 400, 200, 30);
    [RoomSendMessageBT addTarget:self action:@selector(SendRoomChatMessage) forControlEvents:UIControlEventTouchUpInside];
    [RoomSendMessageBT setTitle:@"群发消息" forState:UIControlStateNormal];

    [self.view addSubview:RoomSendMessageBT];
    [self.view addSubview:xmppLoginAndConnectBT];
    [self.view addSubview:xmppRoomLoginBT];
    [self.view addSubview:xmppServerTF];
    [self.view addSubview: xmppPassTF];
    [self.view addSubview:xmppUserTF];
    
    

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


#pragma mark-ChatMsgTableView

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark-xmpp delege
//启动连接操作后，回调函数（委托函数）

//将被调用，表示将要连接
- (void)xmppStreamWillConnect:(XMPPStream *)sender
{
    
}

//登陆服务器成功

- (void)xmppStreamDidConnect:(XMPPStream *)sender
{

NSError *error = nil;

//验证帐户密码

NSString *password = xmppPassTF.text;

    if(![self.xmppStream authenticateWithPassword:password error:&error])
    {
        NSLog(@"AuthenticateWithPassword error :%@",error);
    }
    else
    {
        NSLog(@"Authenticate Done");
    }
}

//验证成功的回调函数

- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender

{
    NSLog(@"%s", __FUNCTION__);
    NSXMLElement *session = [NSXMLElement elementWithName:@"session" xmlns:@"urn:ietf:params:xml:ns:xmpp-session"];
    NSXMLElement *iq = [NSXMLElement elementWithName:@"iq"];


    [iq addAttributeWithName:@"type" stringValue:@"set"];
    [iq addAttributeWithName:@"to" stringValue:xmppStream.hostName];
    [iq addAttributeWithName:@"id" stringValue:@"session_1"];
    
    [iq addChild:session];
    [xmppStream sendElement:iq];
    
    
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"available"];
    //可以加上上线状态，比如忙碌，在线等
    [xmppStream sendElement:presence];//发送上线通知
    
}

//验证失败的回调
-(void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(NSXMLElement *)error
{
    NSLog(@"didNotAuthenticate error :%@",error );
}

//获取好友状态
-(void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence
{
    
    NSLog(@"didReceivePresence %@",presence);
    NSString *presenceType =[presence type];
    NSString *presenceFromUser = [[presence from]user];
    if(![presenceFromUser isEqualToString:[[sender myJID] user]])
    {
        if ([presenceType isEqualToString:@"available"])
        {
            
        }
        else if([presenceType isEqualToString:@"unavailable"])
        {
            
        }
    }
}
//接收消息
-(void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message
{
    
    NSString *messageBody = [[message elementForName:@"body"] stringValue];
    NSLog(@"chat message %@",messageBody);
}


-(void)xmppStream:(XMPPStream *)sender didSendIQ:(XMPPIQ *)iq
{
    NSLog(@"didSendIQ:%@",iq);
}
//接受IQ
-(BOOL)xmppStream:(XMPPStream *)sender didReceiveIQ:(XMPPIQ *)iq
{
    NSLog(@"didReceiveIQ %@",iq);
    if ([@"result" isEqualToString:iq.type])
    {
        NSXMLElement *query =iq.childElement;
        if([@"query" isEqualToString:query.name])
        {
            NSArray *items=[query children];
            [roster removeAllObjects];
            for (NSXMLElement *item in items) {
                
                NSString *groupName =[[NSString alloc]init];
                
                if([item.children count]>0)
                {
                     groupName=[[item.children objectAtIndex:0]stringValue]; //所在组名，在用户没有组名的时候 出BUG
                }
                
                NSString *jid =[item attributeStringValueForName:@"jid"];
                XMPPJID *xmppjid = [XMPPJID jidWithString:jid];
                NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:xmppjid,@"object",@"no",@"presenceType",groupName,@"group", nil];
                
                [roster addObject:dic];
            }
        }
    }

    return YES;
}

-(void)xmppStream:(XMPPStream *)sender didReceiveError:(DDXMLElement *)error
{
    NSLog(@"didReceiveError %@",error);
}

-(void)xmppStream:(XMPPStream *)sender didFailToSendIQ:(XMPPIQ *)iq error:(NSError *)error
{
    NSLog(@"didFailToSendIQ %@",error);
}


#pragma mark-The  xmpp client
-(void)otherconnect
{
    //初始化XMPP 需要的变量部分
    roster =[[NSMutableArray alloc]init];
    
    if (self.xmppStream == nil) {
        self.xmppStream = [[XMPPStream alloc] init];
        [self.xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
        
    }
    if (![self.xmppStream isConnected])
    {
        NSString *username = xmppUserTF.text;
        NSString *domain = xmppServerTF.text;
        
        XMPPJID *jid = [XMPPJID jidWithUser:username domain:domain resource:@"xiren"];
        [self.xmppStream setMyJID:jid];
        [self.xmppStream setHostName:domain];
        NSError *error = nil;
        if (![self.xmppStream connectWithTimeout:30 error:&error]) {
            NSLog(@"Connect Error: %@", [[error userInfo] description]);
        }
        else
        {
            NSLog(@"xmppstream connect done");
        }
    }
}

-(void)disconnect
{
    XMPPPresence *presence =[XMPPPresence presenceWithType:@"unavailable"];
    [xmppStream sendElement:presence];
    [xmppStream disconnect];
}

//发送消息
-(void)sendMessage:(NSString *)message toUser:(NSString *)user
{
    NSXMLElement *body =[NSXMLElement elementWithName:@"body"];
    [body setStringValue:message];
    NSXMLElement *sendmessage =[NSXMLElement elementWithName:@"message"];
    [sendmessage addAttributeWithName:@"type" stringValue:@"chat"];
    NSString *to = [NSString stringWithFormat:@"%@@%@",user,xmppServerTF.text];
    [sendmessage addAttributeWithName:@"to" stringValue:to];
    [sendmessage addChild:body];
    [xmppStream sendElement:sendmessage];
}
//查询ROSTER 花名册
-(void)queryRoster
{
    NSXMLElement *query = [NSXMLElement elementWithName:@"query" xmlns:@"jabber:iq:roster"];
    NSXMLElement *iq = [NSXMLElement elementWithName:@"iq"];
    XMPPJID *myjid =xmppStream.myJID;
    [iq addAttributeWithName:@"type" stringValue:@"get"];
    [iq addAttributeWithName:@"from" stringValue:myjid.description];
    [iq addAttributeWithName:@"to" stringValue:myjid.bare];
    [iq addAttributeWithName:@"id" stringValue:@"bind_1"];
    [iq addChild:query];
    [xmppStream sendElement:iq];
}

#pragma mark-XMPP client
-(void)initXmppRoom
{
    RoomJID= [XMPPJID jidWithString:@"fm961@conference.192.168.1.12"];
    XMPPRoomMemoryStorage *roomMemoryStorage = [[XMPPRoomMemoryStorage alloc]init];
    xmppRoomXiren = [[XMPPRoom alloc]initWithRoomStorage:roomMemoryStorage jid:RoomJID dispatchQueue:dispatch_get_main_queue()];
    [xmppRoomXiren activate:xmppStream];
    [xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
    [xmppRoomXiren joinRoomUsingNickname:xmppUserTF.text history:nil];
}
-(void)SendRoomChatMessage
{
    XMPPMessage *message = [XMPPMessage messageWithType:@"chat" to:RoomJID];
    [message addBody:@"测试"];
    [self.xmppStream sendElement:message];
}
#pragma mark - XMPP ROOM Delegate
- (void)xmppRoom:(XMPPRoom *)sender didConfigure:(XMPPIQ *)iqResult
{
    
}
- (void)xmppRoom:(XMPPRoom *)sender didNotConfigure:(XMPPIQ *)iqResult
{
    
}
//加入后
-(void)xmppRoomDidJoin:(XMPPRoom *)sender
{
    [xmppRoomXiren fetchConfigurationForm];
}

//房间配置信息
-(void)xmppRoom:(XMPPRoom *)sender didFetchConfigurationForm:(DDXMLElement *)configForm
{
    NSLog(@"didFetchConfigurationForm %@",configForm);
}
//收到消息
-(void)xmppRoom:(XMPPRoom *)sender didReceiveMessage:(XMPPMessage *)message fromOccupant:(XMPPJID *)occupantJID
{
    NSLog(@"didReceiveMessage %@",message);
}
//有新人加入
- (void)xmppRoom:(XMPPRoom *)sender occupantDidJoin:(XMPPJID *)occupantJID
{
    NSLog(@"occupantDidJoin %@",occupantJID);
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
