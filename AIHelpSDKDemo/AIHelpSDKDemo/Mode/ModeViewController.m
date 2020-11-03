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

- (IBAction)humanClick:(UIButton *)sender {
    AIHelpConversationConfigBuilder *conversationBuilder = [[AIHelpConversationConfigBuilder alloc] init];
    conversationBuilder.conversationIntent = AIHelpConversationIntentHumanSupport;
    conversationBuilder.welcomeMessage = @"You can configure special welcome message for your end users at here.";
    [AIHelpSupportSDK showConversation:conversationBuilder.build];
}

- (IBAction)robotClick:(UIButton *)sender {
    AIHelpConversationConfigBuilder *conversationBuilder = [[AIHelpConversationConfigBuilder alloc] init];
    [AIHelpSupportSDK showConversation:conversationBuilder.build];
}

- (IBAction)allFAQSection:(UIButton *)sender {
    AIHelpFAQConfigBuilder *faqBuilder = [[AIHelpFAQConfigBuilder alloc] init];
    AIHelpConversationConfigBuilder *conversationBuilder = [[AIHelpConversationConfigBuilder alloc] init];
    faqBuilder.showConversationMoment = AIHelpFAQShowConversationMomentAlways;
    conversationBuilder.conversationIntent = AIHelpConversationIntentHumanSupport;
    conversationBuilder.welcomeMessage = @"You can configure special welcome message for your end users at here.";
    faqBuilder.conversationConfig = conversationBuilder.build;
    [AIHelpSupportSDK showAllFAQSections:faqBuilder.build];
}

- (IBAction)FAQSecton:(UIButton *)sender {
    AIHelpFAQConfigBuilder *faqBuilder = [[AIHelpFAQConfigBuilder alloc] init];
    AIHelpConversationConfigBuilder *conversationBuilder = [[AIHelpConversationConfigBuilder alloc] init];
    faqBuilder.showConversationMoment = AIHelpFAQShowConversationMomentAlways;
    conversationBuilder.conversationIntent = AIHelpConversationIntentHumanSupport;
    conversationBuilder.welcomeMessage = @"You can configure special welcome message for your end users at here.";
    faqBuilder.conversationConfig = conversationBuilder.build;
    [AIHelpSupportSDK showFAQSection:@"SECTION ID" config:faqBuilder.build];
}

- (IBAction)singleFAQ:(UIButton *)sender {
    AIHelpFAQConfigBuilder *faqBuilder = [[AIHelpFAQConfigBuilder alloc] init];
    AIHelpConversationConfigBuilder *conversationBuilder = [[AIHelpConversationConfigBuilder alloc] init];
    faqBuilder.showConversationMoment = AIHelpFAQShowConversationMomentAlways;
    conversationBuilder.conversationIntent = AIHelpConversationIntentHumanSupport;
    conversationBuilder.welcomeMessage = @"You can configure special welcome message for your end users at here.";
    faqBuilder.conversationConfig = conversationBuilder.build;
    [AIHelpSupportSDK showSingleFAQ:@"FAQ ID"  config:faqBuilder.build];
}

- (IBAction)operationClick:(UIButton *)sender {
    AIHelpOperationConfigBuilder *operationBuilder = [[AIHelpOperationConfigBuilder alloc] init];
    AIHelpConversationConfigBuilder *conversationBuilder = [[AIHelpConversationConfigBuilder alloc] init];
    operationBuilder.selectIndex = INT_MAX;
    operationBuilder.conversationTitle = @"Support";
    conversationBuilder.alwaysShowHumanSupportButtonInBotPage = YES;
    conversationBuilder.welcomeMessage = @"You can configure special welcome message for your end users at here.";
    operationBuilder.conversationConfig = conversationBuilder.build;
    [AIHelpSupportSDK showOperation:operationBuilder.build];
}


@end
