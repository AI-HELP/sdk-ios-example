//
//  MessageViewController.h
//  IM30
//
//  Created by Mrxiaowu on 16/1/11.
//  Copyright © 2016年 Mrxiaowu. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface MessageViewController : UIViewController

#define SCREEN_WIDTH         ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT        ([[UIScreen mainScreen] bounds].size.height)

//@property(nonatomic,strong)UIView * backview;
@property (nonatomic)NSMutableArray * tableViewdataArr;
@property (copy,nonatomic)NSString *userName;
@property (copy,nonatomic)NSString *userId;
@property (copy,nonatomic)NSString *title;
@property (assign,nonatomic)int serverId;
@property (assign,nonatomic)NSString *vipChat;//1表示VIP；0:普通用户
@property (nonatomic)NSMutableDictionary *chatPrivates;
@property (copy,nonatomic)NSString *vipChatPrivates;//VIP欢迎信息
@property (copy,nonatomic)NSDictionary *url2Dic;
@property (nonatomic) NSOperationQueue *queue;// 定义操作队列属性
@property (nonatomic) UIActivityIndicatorView *oneIndicatorView;//环形进度条
@property(nonatomic,assign)Boolean isShowIndicator;//是否显示进度
@property (nonatomic)NSMutableDictionary *bootChatCommendDic;
@property(assign,nonatomic) Boolean isReadMessage;
@property int isCommended;
@property (nonatomic,assign)Boolean commendFlag;



+(MessageViewController *)getMessageData;
//- (void)addCustomRely:(NSString *)name result:(NSString *)result urlTitle:(NSString *)urlTitle urlContent:(NSString *)urlContent actionNameStr:(NSString *)actionNameStr acitonReplyStr:(NSString *)acitonReplyStr;
//- (void)addReply:(NSString *)message;
//- (void)sendPicture:(UIImage *)img;

- (void)initParamsWithUserName:(NSString *)userName  UserId:(NSString *)userId Title:(NSString *)title;
-(void)pushOfflineInfo:(NSString *)info;
-(void)getRestoreChatPrivateMessage:(NSMutableDictionary *)chatPrivate;
//-(void)vipIconClicked:(NSDictionary*)pushDicInfos;
@end
