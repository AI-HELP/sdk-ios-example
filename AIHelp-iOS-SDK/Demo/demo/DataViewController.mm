
#import "DataViewController.h"
#import <ElvaChatServiceSDK/ElvaChatServiceSDK.h>

@interface DataViewController ()

@end

@implementation DataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.dataLabel.text = [self.dataObject description];
    if([@"Conversation" isEqualToString:self.dataLabel.text] || [self.dataLabel.text hasSuffix:@"Conversation"]) {
        [self.btnTest setTitle: @"test Conversation"
                      forState:UIControlStateNormal];
    }
    else if([@"FAQs" isEqualToString:self.dataLabel.text] || [self.dataLabel.text hasSuffix:@"FAQs"]) {
        [self.btnTest setTitle: @"test FAQs"
                      forState:UIControlStateNormal];
    }
    else if([@"Elva" isEqualToString:self.dataLabel.text] || [self.dataLabel.text hasSuffix:@"Elva"]) {
        [self.btnTest setTitle: @"test Elva"
                      forState:UIControlStateNormal];
    }
}

-(IBAction) doTest:(id)sender {
    [ECServiceSdk setUserName:@"this_is_player_name"];
    if([@"Conversation" isEqualToString:self.dataLabel.text] || [self.dataLabel.text hasSuffix:@"Conversation"]) {
        [ECServiceSdk showConversation:@"this_is_player_uid"
                              ServerId:@"this_is_server_id"
                                Config:[self makeConfigDictionary]];
    }
    else if([@"FAQs" isEqualToString:self.dataLabel.text] || [self.dataLabel.text hasSuffix:@"FAQs"]) {
        [ECServiceSdk showFAQs:@"this_is_player_name"
                     playerUid:@"this_is_player_uid"
                        config:[self makeConfigDictionary]];
    }
    else if([@"Elva" isEqualToString:self.dataLabel.text] || [self.dataLabel.text hasSuffix:@"Elva"]) {
        [ECServiceSdk showElva:@"this_is_player_name"
                     PlayerUid:@"this_is_player_uid"
                      ServerId:@"this_is_server_id"
                 PlayerParseId:@"this_is_parse_id"
    PlayershowConversationFlag:@"this_is_a_flag"
                        Config:[self makeConfigDictionary]];
    }
}

#pragma mark - PARSER
- (NSMutableDictionary*)makeConfigDictionary {
    [ECServiceSdk setName:@"this_is_game_name"];
    NSMutableDictionary * config = [@{@"elva-custom-metadata":@{
                                            @"elva-tags":@"vip lvl99 pay",
                                            @"testKey":@"testValue",
                                            @"vip":@"vip2",
                                            @"coins":@"0"}
                                    } mutableCopy];
    // 一、联系我们按钮显示逻辑
    //  默认：FAQ列表页和详情页不显示，点击“踩”，显示联系我们按钮
    //  一直显示：设置 'showContactButtonFlag'
    //  永不显示：设置 'hideContactButtonFlag'
    [config setObject:@"1" forKey:@"showContactButtonFlag"];
    // 二、点击联系我们按钮（经过一步骤，显示了联系我们按钮的前提）进入客服页面的逻辑
    //  默认：进入机器人页面（无进行中客诉时，不显示人工客服按钮）
    //  直接进入人工页面：设置 'directConversation'
    //  进入机器人页面+人工客服入口按钮：设置 'showConversationFlag'
    [config setObject:@"1" forKey:@"showConversationFlag"];
    return config;
}

@end
