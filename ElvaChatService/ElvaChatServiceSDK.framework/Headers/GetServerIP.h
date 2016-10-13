//
//  GetServerIP.h
//  ElvaTestIOS
//
//  Created by 杨津 on 16/4/20.
//  Copyright © 2016年 im30. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface GetServerIP : NSObject
@property(nonatomic,strong)NSString *showUrl;
@property(nonatomic,strong)NSString *showfaq;
@property(nonatomic,strong)NSString *showfaqlist;
@property (copy,nonatomic)NSString *customerData;
@property(nonatomic,strong)NSString *appId;
@property(nonatomic,strong)NSString *appSecret;
@property(nonatomic,strong)NSString *domain;
@property (copy,nonatomic)NSString *deviceToken;
@property int serverId;
@property (copy,nonatomic)NSString *playerParseId;
@property(nonatomic,assign)Boolean isToken;
@property (copy,nonatomic)NSString *gameName;
@property (copy,nonatomic)NSString *userId;
@property (copy,nonatomic)NSString *upload;
@property (copy,nonatomic)NSString *userName;
@property (copy,nonatomic)NSString *faqData;
@property (copy,nonatomic)NSString *logUrl;
@property (copy,nonatomic)NSString *faqKey;
@property (copy,nonatomic)NSString *showVipChat;
//@property int isCommended;
+ (void)getServerMsgWithAppId:(NSString *)appSecret Domain:(NSString *)domain appId:(NSString *)appId;

+(GetServerIP *)getFaqService;

- (void)setGameName:(NSString *)gameName;



@end
