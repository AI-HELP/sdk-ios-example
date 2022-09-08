//
//  ModeViewController.m
//  AIHelpSDKDemo
//
//  Created by AIHelp on 2020/10/21.
//

#import "ModeViewController.h"
#import <AIHelpSupportSDK/AIHelpSupportSDK.h>

@interface ModeViewController ()

@end

@implementation ModeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"mode";
}

- (IBAction)showWithEntranceId:(UIButton *)sender {
    [AIHelpSupportSDK showWithEntranceId:@"THIS IS YOUR ENTRANCE ID"];
}

- (IBAction)showWithApiConfig:(UIButton *)sender {
    AIHelpApiConfigBuilder *builder = [[AIHelpApiConfigBuilder alloc] init];
    builder.entranceId = @"THIS IS YOUR ENTRANCE ID";
    builder.welcomeMessage = @"THIS IS YOUR WELCOME MESSAGE";
    [AIHelpSupportSDK showWithApiConfig:builder.build];
}

@end
