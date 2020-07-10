//
//  ECServiceCocos2dx.h
//  ElvaChatService Cocos2dx SDK
//

#import <Foundation/Foundation.h>

/*
 * notify the application when some state changes in Elva.
 * eventCode:
 *    2: Elva UI Visible Changed
 *          state (0) : will show elva ui
 *          state (1) : all elva ui are closed
 */
typedef void (*ElvaEventCallBack)(const int eventCode, const int state);
typedef BOOL (*ElvaPingCallBack)(const NSString * log);
typedef void (*ElvaInitCallBack)(void);
typedef void (*ElvaMessageCallBack)(const NSString * jsonString);
typedef void (*ElvaAllowUploadLogMessageCallback)(void);

@class UIViewController;
typedef NS_ENUM(int,ElvaTokenPlatform) {
    ElvaTokenPlatformAPNS               = 1,//APNS
    ElvaTokenPlatformFirebase           = 2,//firebase-FCM
    ElvaTokenPlatformJpush              = 3,//极光推送
    ElvaTokenPlatformGeTui              = 4,//个推
};
@interface ECServiceSdk:NSObject
#pragma mark - ------init------
+ (void) init:(NSString*) appSecret Domain:(NSString*) domain AppId:(NSString*) appId;
#pragma mark - ------showElva------
+ (void) showElva:(NSString*) playerName PlayerUid:(NSString*) playerUid ServerId:(NSString*) serverId PlayerParseId:(NSString*) playerParseId PlayershowConversationFlag:(NSString*) playershowConversationFlag;
+ (void) showElva:(NSString*) playerName PlayerUid:(NSString*) playerUid ServerId:(NSString*) serverId PlayerParseId:(NSString*) playerParseId PlayershowConversationFlag:(NSString*) playershowConversationFlag Config:(NSDictionary*) config;
#pragma mark - ------showConversation------
+ (void) showConversation:(NSString*) playerUid ServerId:(NSString*) serverId;//请优先实现setUserName接口
+ (void) showConversation:(NSString*) playerUid ServerId:(NSString*) serverId Config:(NSDictionary*) config;
#pragma mark - ------showElvaOP------
+ (void) showElvaOP:(NSString*) playerName PlayerUid:(NSString*) playerUid ServerId:(NSString*) serverId PlayerParseId:(NSString*) playerParseId PlayershowConversationFlag:(NSString*) playershowConversationFlag Config:(NSDictionary *)config;

+ (void) showElvaOP:(NSString*) playerName PlayerUid:(NSString*) playerUid ServerId:(NSString*) serverId PlayerParseId:(NSString*) playerParseId PlayershowConversationFlag:(NSString*) playershowConversationFlag Config:(NSDictionary *)config defaultTabIndex:(int)defaultTabIndex;
#pragma mark - ------showFAQ------
+ (void) showFAQs;
+ (void) showFAQs:(NSDictionary*)config;
+ (void) showFAQs:(NSString*)playerName playerUid:(NSString*)playerUid;
+ (void) showFAQs:(NSString*)playerName playerUid:(NSString*)playerUid config:(NSDictionary*)config;

+ (void) showFAQSection:(NSString*) sectionPublishId;
+ (void) showFAQSection:(NSString*) sectionPublishId Config:(NSDictionary*) config;

+ (void) showSingleFAQ:(NSString*) faqId;
+ (void) showSingleFAQ:(NSString*) faqId Config:(NSDictionary*) config;

#pragma mark - ------other------
+ (void) showVIPChat:(NSString*) appidWeb VIPTags:(NSString *) vipTags;
+ (void) showQACommunity:(NSString *)playerUid PlayName:(NSString *)playerName;

+ (void) showURL:(NSString *) url;
+ (void) showStoreReview;

+ (void) setRootViewController:(UIViewController*)rootViewController;
+ (void) setUserId:(NSString*) playerUid;//自助服务，在showFAQ之前调用
+ (void) setUserName:(NSString*) playerName;//在需要的接口之前调用，建议游戏刚进入就默认调用
+ (void) setName:(NSString*) game_name;
+ (void) setOpenLog:(BOOL)isOpen;
+ (void) setServerId:(NSString*) serverId;//自助服务，在showFAQ之前调用
+ (void) setAccelerateDomain:(NSString *)domain;
+ (void) setSDKLanguage:(NSString*) sdkLanguage;
+ (void) setUseDevice;
+ (void) setSendCloseNotification:(BOOL) isSend;//关闭某一项是否发送通知
+ (void) setEvaluateStar:(int) star;//设置默认评价星星个数

+ (void) setChangeDirection;
+ (void) setSDKInterfaceOrientationMask:(NSUInteger)interfaceOrientationMask;//参数参考UIInterfaceOrientationMask
+ (void) setNoMenu;

+ (void) setVIP:(NSString *)userName userId:(NSString *)userId config:(NSDictionary*)config;

+ (void) registerUnityOnInitializedCallback:(NSString *) gameObject;
+ (void) registerUnityOnMessageArrivedCallback:(NSString *) gameObject;
+ (void) registerUnityOnSendMessageSuccessCallback:(NSString *) gameObject;
+ (void) registerDeviceToken:(NSString*) deviceToken isVIP:(Boolean) isVip;
+ (void) handlePushNotification:(NSDictionary *) table DataFromInApp:(BOOL) dataFromInApp;
+ (int) getNotificationMessageCount;

+ (void) setUnreadMessageFetchUid:(NSString*) playerUid;


+ (NSString*)sdkVersionInfo;
+ (BOOL) isInSDKPageView;
+ (void) setSDKEdgeInsetsWithTop:(float)top bottom:(float)bottom enable:(BOOL)enable;
+ (void) setSDKEdgeColorWithRed:(float)red green:(float)green blue:(float)blue alpha:(float)alpha;//0~1

+ (void) setEventListener:(ElvaEventCallBack)callback;
+ (void) setPushToken:(NSString*)pushToken pushPlatform:(ElvaTokenPlatform)pushPlatform;//platform参考1:APNS 2:firebase 3:极光推送 4:个推
+ (void)setNetCheckInfoWithIp:(NSString*)ip callback:(ElvaPingCallBack)callback;


+ (void)setOnMessageArrivedCallback:(ElvaMessageCallBack)callback;//红点消息的回调
+ (void)setOnInitializedCallback:(ElvaInitCallBack)callback;//初始化回调

+ (void)setAllowUploadLogMessageCallback:(ElvaAllowUploadLogMessageCallback)callback;
+ (void)setUploadLogFileAtPath:(NSString*)path;
@end
