//
//  ShowFAQListController.h
//  ElvaMqttIOS
//
//  Created by wwj on 16/8/3.
//  Copyright © 2016年 wwj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ShowFAQListController : UIViewController

@property(nonatomic) NSMutableArray *dataArray;

@property (nonatomic, copy) NSURL *SSIUrl;
@property (nonatomic, retain)UIMenuItem *selfInterfaceItem;
@property (nonatomic, retain)UIMenuItem *creatManue;
@property (nonatomic, assign) bool isShowSelfBtn;
@property (nonatomic, assign) bool isShowManue;
@property (nonatomic, assign) bool isShowUserSelfBtn;
@property (nonatomic, assign) bool isShowFaqList;
//@property(strong,nonatomic) UINavigationController *nav;
//@property (strong, nonatomic) UIWindow *window;
@end
