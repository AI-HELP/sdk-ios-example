//
//  ShowFAQSectionController.h
//  ElvaMqttIOS
//
//  Created by wwj on 16/8/4.
//  Copyright © 2016年 wwj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ShowFAQSectionController : UIViewController

@property(nonatomic) NSMutableArray *dataArray;

@property (nonatomic, copy) NSURL *SSIUrl;
@property (nonatomic, retain)UIMenuItem *selfInterfaceItem;
@property (nonatomic, retain)UIMenuItem *creatManue;
@property (nonatomic, assign) bool isShowSelfBtn;
@property (nonatomic, assign) bool isShowManue;
@property (nonatomic, assign) bool isShowUserSelfBtn;
@property (nonatomic, assign) bool isShowFaqList;

@property(nonatomic,copy)NSString *sectionId;

@end
