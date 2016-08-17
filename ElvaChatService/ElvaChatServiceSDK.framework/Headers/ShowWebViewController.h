//
//  ShowWebViewController.h
//  FanClub
//
//  Created by zhangyang@ifensi.com on 15/5/11.
//  Copyright (c) 2015年 ifens. All rights reserved.
//

//#import "BaseViewController.h"
#import <UIKit/UIColor.h>
#import <UIKit/UIViewController.h>
#import <UIKit/UIMenuController.h>
#import <UIKit/UIKit.h>
@interface ShowWebViewController : UIViewController

/*
 webView需要显示的URL
 */
@property (nonatomic, copy) NSURL *url;
@property (nonatomic, copy) NSURL *SSIUrl;
@property (nonatomic, retain)UIMenuItem *selfInterfaceItem;
@property (nonatomic, retain)UIMenuItem *creatManue;
/*
 进度条的颜色
 */
@property (nonatomic, copy) UIColor *loadingBarTintColor;
@property (nonatomic,copy) NSString *contentStr;

@property (nonatomic, assign) bool showLoadingBar;
@property (nonatomic, assign) bool isShowSelfBtn;
@property (nonatomic, assign) bool isShowManue;
@property (nonatomic, assign) bool isShowUserSelfBtn;
@property (nonatomic, assign) bool isShowFaqList;
@property int loadedCount;
@property (nonatomic) UIActivityIndicatorView *oneIndicatorView;//环形进度条
/** 是否不显示导航栏右上角点点点 */
@property (nonatomic, assign) bool noMoreBtn;

- (void)refreshwCurrentWebView:(NSURL *)url;
-(void)showSelfInterface:(NSString *)faqid;
@end
