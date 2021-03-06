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
@property (strong,nonatomic) XMPPJID *RoomJID;
@property (strong,nonatomic) XMPPRoom *xmppRoomXiren;
@property (retain,nonatomic) NSMutableArray *talkListContent;
@property (retain,nonatomic) NSMutableArray *talkListName;
@property (retain,nonatomic) NSMutableArray *talkListFace;


@property (retain,nonatomic) UITextField *xmppUserTF; //TF代表TEXTFILED
@property (retain,nonatomic) UITextField *xmppPassTF;
@property (retain,nonatomic) UITextField *xmppServerTF;
@property (retain,nonatomic) UITextView *talkMessageView;
@property (retain,nonatomic) UIView *buttomArea;


@end

@implementation RadioViewController

@synthesize xmppStream;
@synthesize roster;
@synthesize xmppPassTF;
@synthesize xmppServerTF;
@synthesize xmppUserTF;
@synthesize xmppRoomXiren;
@synthesize RoomJID;
@synthesize ChatMsgTableView;
@synthesize talkListName;
@synthesize talkListContent;
@synthesize talkListFace;
@synthesize lastChatMessage;
@synthesize talkMessageView;
@synthesize buttomArea;
#define TableHeight 150
#define Table_Y 250
#define ChatViewHeight 50
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
    

    
    //接收消息存储器
    talkListContent = [[NSMutableArray alloc]init];
    talkListName = [[NSMutableArray alloc]init];
    talkListFace = [[NSMutableArray alloc]init];
    lastChatMessage = [[XMPPMessage alloc]init];
    
    
    //textfield 部分
    xmppUserTF =[[UITextField alloc]initWithFrame:CGRectMake(5, 60, 100, 30)];
    xmppUserTF.placeholder = @"用户名";
    xmppUserTF.borderStyle = UITextBorderStyleBezel;
    xmppUserTF.clearButtonMode = UITextFieldViewModeAlways;
    xmppUserTF.text = @"pipi";
    
    xmppPassTF = [[UITextField alloc]initWithFrame:CGRectMake(110, 60, 100, 30)];
    xmppPassTF.placeholder = @"密码";
    xmppPassTF.borderStyle=UITextBorderStyleBezel;
    xmppPassTF.clearButtonMode = UITextFieldViewModeAlways;
    xmppPassTF.text= @"vmvnv1v2";
    
    xmppServerTF = [[UITextField alloc]initWithFrame:CGRectMake(220, 60, 100, 30)];
    xmppServerTF.placeholder=@"服务器";
    xmppServerTF.borderStyle =UITextBorderStyleBezel;
    xmppServerTF.clearButtonMode = UITextFieldViewModeAlways;
    xmppServerTF.text = @"192.168.1.12";
    
    //聊天内容输入窗口初始化
    talkMessageView = [[UITextView alloc]initWithFrame:CGRectMake(10, 0, 200, 30)];
    talkMessageView.text =@"测试信息";
    talkMessageView.returnKeyType = UIReturnKeyDefault;
    talkMessageView.keyboardType = UIKeyboardTypeDefault;
    talkMessageView.layer.borderWidth=1.0;
    talkMessageView.layer.borderColor = [[UIColor colorWithRed:230.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0]CGColor];
    [talkMessageView.layer setMasksToBounds:YES];
    talkMessageView.autoresizingMask= UIViewAutoresizingFlexibleHeight;
    talkMessageView.clearsContextBeforeDrawing=YES;
    talkMessageView.delegate=self;
    
    //按钮部分
    UIButton *xmppLoginAndConnectBT=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    xmppLoginAndConnectBT.frame =CGRectMake(130, 0, 100, 50);
    [xmppLoginAndConnectBT addTarget:self action:@selector(otherconnect) forControlEvents:UIControlEventTouchUpInside];
    [xmppLoginAndConnectBT setTitle:@"连接并登陆服务器" forState:UIControlStateNormal];
    
    UIButton *xmppRoomLoginBT=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    xmppRoomLoginBT.frame =CGRectMake(240, 0, 100, 50);
    [xmppRoomLoginBT addTarget:self action:@selector(initXmppRoom) forControlEvents:UIControlEventTouchUpInside];
    [xmppRoomLoginBT setTitle:@"进入房间" forState:UIControlStateNormal];
    
    UIButton *RoomSendMessageBT=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    RoomSendMessageBT.frame =CGRectMake(kDeviceWidth-120, 0, 100, 30);
    [RoomSendMessageBT addTarget:self action:@selector(SendRoomChatMessage:) forControlEvents:UIControlEventTouchUpInside];
    [RoomSendMessageBT setTitle:@"发送" forState:UIControlStateNormal];
    
    //xmpp按钮部分
    UIButton *chatSenButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    chatSenButton.frame =CGRectMake(20, 0, 100, 50);
    [chatSenButton addTarget:self action:@selector(queryRoster) forControlEvents:UIControlEventTouchUpInside];
    [chatSenButton setTitle:@"查看好友列表" forState: UIControlStateNormal];
    [self.view addSubview:chatSenButton];

    //TableView 部分
    ChatMsgTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-KTabarHeight-ChatViewHeight) style:UITableViewStylePlain];
    ChatMsgTableView.dataSource =self;
    ChatMsgTableView.delegate = self;
    ChatMsgTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //table bottom VIEW 部分
    buttomArea= [[UIView alloc]initWithFrame:CGRectMake(0, kDeviceHeight-KTabarHeight-ChatViewHeight, kDeviceWidth, ChatViewHeight)];
    [buttomArea addSubview:RoomSendMessageBT];
    [buttomArea addSubview:talkMessageView];

    
    //table topview
    UIView *tableTopView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 100)];
    [tableTopView addSubview:chatSenButton];
    [tableTopView addSubview:xmppLoginAndConnectBT];
    [tableTopView addSubview:xmppRoomLoginBT];
    [tableTopView addSubview:xmppUserTF];
    [tableTopView addSubview:xmppPassTF];
    [tableTopView addSubview:xmppServerTF];
    [ChatMsgTableView setTableHeaderView:tableTopView];
    

    
    [self.view addSubview:ChatMsgTableView];
    [self.view addSubview:buttomArea];
    

}
#pragma mark-system delegate
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
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

#pragma mark-chatMsgTableView functions
-(void)reloadTableView
{
    [ChatMsgTableView reloadData];
    if (talkListContent.count>0){
        [ChatMsgTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:talkListContent.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

#pragma mark-ChatMsgTableView delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *contentListIdentifier= @"FM961chat";
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
    
    cell.textLabel.text = talkListContent[row];
    cell.imageView.image = [UIImage imageNamed:@"list_head sculpture"];
    cell.detailTextLabel.text =talkListName[row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    return cell;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return talkListContent.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* chat=self.talkListContent[indexPath.row];
    CGFloat height=[self calculateMessageSize:chat];
    return fmaxf(height+44.0f, 60.0f);
}
-(CGFloat)calculateMessageSize:(NSString*)message{
    NSDictionary* attributes=@{NSFontAttributeName:[UIFont systemFontOfSize:17.0f]};
    //    CGSize size=[message sizeWithAttributes:attributes];
    //    return size.height+44.0f;
    CGRect rect=[message boundingRectWithSize:CGSizeMake(320.0f, 300.0f) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    return ceilf(rect.size.height);
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
    [iq addAttributeWithName:@"id" stringValue:[NSString stringWithFormat:@"session_%@",[[xmppStream myJID] user]]];
    
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

    NSString *messageBody = [message body];

    if (message.childCount>0)
    {
        for (NSXMLElement *item in message.children)
        {
            if ([item.name isEqualToString:@"delay"])
            {
//                return;
            }
            else if ([messageBody length]>0 && [message.type isEqualToString:@"groupchat"] && message !=lastChatMessage)//同时过滤重复发送的信息
            {
                NSString *messageFrom = [message from].resource;
                [talkListContent addObject:messageBody];
                [talkListName addObject:messageFrom];
                
                
            }
        }
    }
    NSLog(@"user to user didReceiveMessage body=%@,message=%@",messageBody,message);
    [self reloadTableView];
    lastChatMessage=message;
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
//-(void)sendMessage:(NSString *)message toUser:(NSString *)user
//{
//    NSXMLElement *body =[NSXMLElement elementWithName:@"body"];
//    [body setStringValue:message];
//    NSXMLElement *sendmessage =[NSXMLElement elementWithName:@"message"];
//    [sendmessage addAttributeWithName:@"type" stringValue:@"chat"];
//    NSString *to = [NSString stringWithFormat:@"%@@%@",user,xmppServerTF.text];
//    [sendmessage addAttributeWithName:@"to" stringValue:to];
//    [sendmessage addChild:body];
//    [xmppStream sendElement:sendmessage];
//}
//查询ROSTER 花名册
-(void)queryRoster
{
    NSXMLElement *query = [NSXMLElement elementWithName:@"query" xmlns:@"jabber:iq:roster"];
    NSXMLElement *iq = [NSXMLElement elementWithName:@"iq"];
    XMPPJID *myjid =xmppStream.myJID;
    [iq addAttributeWithName:@"type" stringValue:@"get"];
    [iq addAttributeWithName:@"from" stringValue:myjid.description];
    [iq addAttributeWithName:@"to" stringValue:myjid.bare];
    [iq addAttributeWithName:@"id" stringValue:@"xiren"];
    [iq addChild:query];
    [xmppStream sendElement:iq];
    [self getChatRoomList];
}

#pragma mark-XMPPRoom client
-(void)initXmppRoom
{
    RoomJID= [XMPPJID jidWithString:@"fm961@conference.192.168.1.12"];
    XMPPRoomMemoryStorage *roomMemoryStorage = [[XMPPRoomMemoryStorage alloc]init];
    xmppRoomXiren = [[XMPPRoom alloc]initWithRoomStorage:roomMemoryStorage jid:RoomJID dispatchQueue:dispatch_get_main_queue()];
    [xmppRoomXiren activate:xmppStream];
    [xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
    [xmppRoomXiren joinRoomUsingNickname:xmppUserTF.text history:nil];
}
-(void)SendRoomChatMessage:(NSString *)chatmessage
{
    XMPPMessage *message = [XMPPMessage messageWithType:@"groupchat" to:RoomJID];
    [message addAttributeWithName:@"xmlns" stringValue:@"jabber:client"];
    [message addAttributeWithName:@"from" stringValue:xmppStream.myJID.description];
    if(talkMessageView.text.length>0)
    {
        [message addBody:talkMessageView.text];
        [self.xmppStream sendElement:message];
    }

}
-(void)getChatRoomList
{
    NSXMLElement *iq =[NSXMLElement elementWithName:@"iq"];
    [iq addAttributeWithName:@"from" stringValue:xmppStream.myJID.description];
    [iq addAttributeWithName:@"to" stringValue:@"conference.192.168.1.12"];
    [iq addAttributeWithName:@"id" stringValue:@"getexistroomid"];
    [iq addAttributeWithName:@"type" stringValue:@"get"];
    NSXMLElement *query =[NSXMLElement elementWithName:@"query"];
    [query addAttributeWithName:@"xmlns" stringValue:@"http://jabber.org/protocol/disco#items"];
    [iq addChild:query];
    [xmppStream sendElement:iq];
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


//有新人加入
- (void)xmppRoom:(XMPPRoom *)sender occupantDidJoin:(XMPPJID *)occupantJID
{
    NSLog(@"occupantDidJoin %@",occupantJID);
}

#pragma mark-Keyboard
//-(void)keyboardWillShow:(NSNotification *)aNotification
//{
//    CGRect keyboardRect = [[[aNotification userInfo] objectForKey:UIKeyboardBoundsUserInfoKey]CGRectValue];
//    NSTimeInterval animationDuration = [[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey]doubleValue];
//    CGFloat NEW_Y= self.view.origin.y - keyboardRect.size.height;
//
//    CGRect newChatViewFrame =CGRectMake(0, NEW_Y, kDeviceWidth, self.view.height);
//
//    NSLog(@"when keyboard up talkMessageView.frame = %@",self.view.frame);
//    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
//   [UIView setAnimationDuration:animationDuration];
//    self.view.frame =newChatViewFrame;
//   [UIView commitAnimations];
//}

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

#pragma mark-keybord delegate

#pragma mark-textview delegate
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    int offset= -(self.view.frame.size.height-252.0);
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
        self.view.frame = CGRectMake(0, -216+32, kDeviceWidth, kDeviceHeight);

    [UIView commitAnimations];
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
