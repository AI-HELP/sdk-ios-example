//
//  OtherViewController.m
//  AIHelpSDKDemo
//
//  Created by AIHelp on 2020/10/21.
//

#import "OtherViewController.h"
#import <AIHelpSupportSDK/AIHelpSupportSDK.h>

@interface OtherViewController ()

@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"other";
    
}

void AIHelp_onNetworkCheckResult(const NSString * netLog) {
    NSLog(@"AIHelp_onNetworkCheckResult");
}
- (IBAction)networkCheckClick:(UIButton *)sender {
    
    [AIHelpSupportSDK setNetworkCheckHostAddress:@"aihelp.net" callback:AIHelp_onNetworkCheckResult];

}

- (IBAction)uploadLogClick:(UIButton *)sender {
    [AIHelpSupportSDK setUploadLogPath:@""];
}


void AIHelp_unreadMessageArrived(const int count)  {
    NSLog(@"AIHelp_unreadMessageArrived");
}
- (IBAction)UnreadMessageClick:(UIButton *)sender {
    [AIHelpSupportSDK startUnreadMessageCountPolling:AIHelp_unreadMessageArrived];
}


- (IBAction)pushClick:(UIButton *)sender {
    [AIHelpSupportSDK setPushToken:@"PUSH_TOKEN" pushPlatform:AIHelpTokenPlatformGeTui];
}

@end
