//
//  SettingViewController.m
//  AIHelpSDKDemo
//
//  Created by AIHelp on 2020/10/21.
//

#import "SettingViewController.h"
#import <AIHelpSupportSDK/AIHelpSupportSDK.h>

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"setting";
}

- (IBAction)setUserInfoClick:(UIButton *)sender {
    AIHelpUserConfigBuilder *userBuilder = [[AIHelpUserConfigBuilder alloc] init];
    userBuilder.userId = @"123456789";
    userBuilder.userName = @"AIHelper";
    userBuilder.userTags = @[@"recharge", @"vip1", @"paid3"];
    userBuilder.customData = @{@"level":@34, @"total_recharge":@300, @"remaining":@"56"};
    [AIHelpSupportSDK updateUserInfo:userBuilder.build];
}

- (IBAction)switchLanguageClick:(UIButton *)sender {
    [AIHelpSupportSDK updateSDKLanguage:@"en"];
}

- (IBAction)setSDKInterfaceOrientation:(UIButton *)sender {
    
}

@end
