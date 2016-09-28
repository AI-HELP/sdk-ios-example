//
//  ChatMessageViewController.h
//  ElvaTestIOS
//
//  Created by wwj on 16/5/16.
//  Copyright © 2016年 im30. All rights reserved.
//



///测试代码更改是否生效

#import <UIKit/UIKit.h>


@interface ChatMessageViewController : UIViewController


@property (nonatomic)NSMutableArray * tableViewdataArr;
@property (copy,nonatomic)NSString *userName;
@property (copy,nonatomic)NSString *userId;
@property (copy,nonatomic)NSString *title;
@property (copy,nonatomic)NSString *type;//0表示登录之后进入VIPchat；1：表示直接进入vipchat
@property (nonatomic)NSMutableDictionary *chatPrivate;
@property (copy,nonatomic)NSString *vipWelcomeMsg;
@property (copy,nonatomic)NSDictionary *chatFromMeDic;
@property(nonatomic,assign)Boolean isFirstMsg;
@property (nonatomic) NSOperationQueue *queue;// 定义操作队列属性
@property (nonatomic) UIActivityIndicatorView *oneIndicatorView;//环形进度条

@property (nonatomic)NSMutableDictionary *commentDetailDic;//评论radioDic
@property (copy,nonatomic)NSString *star_index;//选择的第几颗星
@property (copy,nonatomic)NSString *chooseid;//不满意选项id
@property (nonatomic ,strong) UIView *deliverView; //底部View
@property (nonatomic)NSMutableDictionary *peopleChatCommendDic;
@property int contentHight;
+(ChatMessageViewController *)getMessageDate;
//- (void)addCustomRely:(NSString *)name result:(NSString *)result urlTitle:(NSString *)urlTitle urlContent:(NSString *)urlContent actionNameStr:(NSString *)actionNameStr acitonReplyStr:(NSString *)acitonReplyStr;
//- (void)addReply:(NSString *)message;

//- (void)sendPicture:(UIImage *)img;
//- (void)sendPicture:(UIImage *)img;
- (void)initParamsWithUserName:(NSString *)userName  UserId:(NSString *)userId Title:(NSString *)title;
-(void)getRestoreChatPrivateMessage:(NSMutableDictionary *)chatPrivate;

@end
