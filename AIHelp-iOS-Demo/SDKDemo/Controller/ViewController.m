
#import "ViewController.h"
#import <ElvaChatServiceSDK/ElvaChatServiceSDK.h>
#import "XYLanguageController.h"

@implementation ViewController
////隐藏顶部栏
//- (BOOL)prefersStatusBarHidden {
//    return YES;//隐藏为YES，显示为NO
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableFooterView];
}
- (void)createTableFooterView {
    //点击联系我们按钮，直接进入机器人（机器人
    NSArray * titles = @[@"UserId",@"UserName",@"AppName",@"ServerId",@"parseRegisterId",@"tags",@"关闭前端化",@"FAQ显示联系我们",@"点击联系我们"];
    NSString * uid = [NSUserDefaults.standardUserDefaults objectForKey:@"test.config.uid"];
    NSString * uname = [NSUserDefaults.standardUserDefaults objectForKey:@"test.config.uname"];
    NSString * gname = [NSUserDefaults.standardUserDefaults objectForKey:@"test.config.gname"];
    NSArray * values = @[uid?uid:@"The_User_ID",
                         uname?uname:@"The_User_Name",
                         gname?gname:@"The_App_Name",
                         @"S123",
                         @"",
                         @"VIP1,PAY10W"];
    
    UIView * footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30*titles.count)];
    footerView.layer.borderColor = [UIColor cyanColor].CGColor;
    footerView.layer.borderWidth = 1;
    for (int i=0; i<titles.count; i++) {
        UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(0, i*30, 150, 30)];
        [footerView addSubview:lab];
        lab.text = titles[i];
        
        if (i<values.count) {
            UITextField * txf = [[UITextField alloc] initWithFrame:CGRectMake(150, i*30, CGRectGetWidth(self.view.bounds)-150, 30)];
            txf.placeholder = lab.text;
            txf.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            [footerView addSubview:txf];
            txf.layer.borderColor = [UIColor lightGrayColor].CGColor;
            txf.layer.borderWidth = 1.0/UIScreen.mainScreen.scale;
            txf.text = values[i];
            txf.tag = i+100;
            
            UIToolbar * toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
            txf.inputAccessoryView = toolBar;
            toolBar.items = @[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                              [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:txf action:@selector(resignFirstResponder)]];
            txf.inputAccessoryView = toolBar;
        }
        //关闭前端化
        else if (i == values.count){
            UISwitch * sw = [[UISwitch alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.bounds)-150, i*30, 70, 30)];
            [sw sizeToFit];
            CGRect frame = sw.frame;
            frame.origin.x = CGRectGetWidth(self.view.bounds)-sw.bounds.size.width-10;
            frame.origin.y = i*30;
            sw.frame = frame;
            [footerView addSubview:sw];
            sw.on = YES;
            sw.tag = i+100;
            sw.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
            lab.frame = CGRectMake(0, i*30, CGRectGetWidth(self.view.bounds)-CGRectGetWidth(sw.bounds)-10, 30);
            lab.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            self.sw_local = sw;
        }
        else {
            UISegmentedControl * sc = [[UISegmentedControl alloc] initWithFrame:CGRectMake(150, i*30, CGRectGetWidth(self.view.bounds)-150, 30)];
            [footerView addSubview:sc];
            sc.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            //显示逻辑
            if (i-values.count==1) {
                [sc insertSegmentWithTitle:@"点踩显示" atIndex:0 animated:NO];
                [sc insertSegmentWithTitle:@"长显" atIndex:1 animated:NO];
                [sc insertSegmentWithTitle:@"永不" atIndex:2 animated:NO];
                sc.selectedSegmentIndex = 0;
                self.sc_show = sc;
            }
            //进入逻辑
            if (i-values.count==2) {
                [sc insertSegmentWithTitle:@"机器" atIndex:0 animated:NO];
                [sc insertSegmentWithTitle:@"人工" atIndex:1 animated:NO];
                [sc insertSegmentWithTitle:@"机器+人工" atIndex:2 animated:NO];
                sc.selectedSegmentIndex = 0;
                self.sc_logic = sc;
            }
        }
    }
    self.tableView.tableFooterView = footerView;
    
    self.txf_uid = (UITextField*)[self.tableView.tableFooterView viewWithTag:100];
    self.txf_uname = (UITextField*)[self.tableView.tableFooterView viewWithTag:101];
    self.txf_gname = (UITextField*)[self.tableView.tableFooterView viewWithTag:102];
    self.txf_serverid = (UITextField*)[self.tableView.tableFooterView viewWithTag:103];
    self.txf_ppid = (UITextField*)[self.tableView.tableFooterView viewWithTag:104];
    self.txf_tags = (UITextField*)[self.tableView.tableFooterView viewWithTag:105];
    
}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
            case 0:return @"language";
            case 1:return @"FAQ";
            case 2:return @"Elva";
            case 3:return @"Other";
        default:return nil;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
            case 0:return 1;
            case 1:return 3;
            case 2:return 3;
            case 3:return 2;
        default:return 0;
    }
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"];
        cell.textLabel.textAlignment = 1;
        cell.textLabel.textColor = [UIColor blueColor];
        cell.textLabel.font = [UIFont systemFontOfSize:20];
    }
    
    switch (indexPath.section) {
            case 0:cell.textLabel.text=@"切换语言";break;
            case 1:{
                switch (indexPath.row) {
                        case 0:cell.textLabel.text=@"showFAQs";break;
                        case 1:cell.textLabel.text=@"showFAQSection";break;
                        case 2:cell.textLabel.text=@"showSingleFAQ";break;
                }
            }break;
            case 2: {
                switch (indexPath.row) {
                        case 0:cell.textLabel.text=@"showElvaOP";break;
                        case 1:cell.textLabel.text=@"showElva";break;
                        case 2:cell.textLabel.text=@"showConversation";break;
                }
            }break;
            case 3: {
                switch (indexPath.row) {
                        case 0:cell.textLabel.text=@"Show URL";break;
                        case 1:cell.textLabel.text=@"Set VIP";break;
                }
            }break;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self parserConfigDictionaryWithRightButtonIsShow:NO];
    switch (indexPath.section) {
            case 0:[self onClickShowLanguageList];break;
            case 1:{
                switch (indexPath.row) {
                        case 0:[self onClickShowLocalFAQ];break;
                        case 1:[self onClickShowWebFAQ];break;
                        case 2:[self onClickShowSingleFAQ];break;
                }
            }break;
            case 2: {
                switch (indexPath.row) {
                        case 0:[self onClickShowOperateModule];break;
                        case 1:[self onClickShowRebotChat];break;
                        case 2:[self onClickShowPersonChat];break;
                }
            }break;
            case 3: {
                switch (indexPath.row) {
                        case 0:[self onClickShowWebURL];break;
                        case 1:[self onClickSetVIP];break;
                }
            }break;
    }
}
#pragma mark - PARSER
- (NSMutableDictionary*)parserConfigDictionaryWithRightButtonIsShow:(BOOL)show {
    if (self.txf_gname.text.length > 0) {
        [ECServiceSdk setName:self.txf_gname.text];
    }
    
//    if (ECAliceManager.sharedManager.isStoryProcessed) {
//        ECAliceManager.sharedManager.isStoryProcessed = self.sw_local.on;
//    }

    [NSUserDefaults.standardUserDefaults setObject:self.txf_uid.text forKey:@"test.config.uid"];
    [NSUserDefaults.standardUserDefaults setObject:self.txf_uname.text forKey:@"test.config.uname"];
    [NSUserDefaults.standardUserDefaults synchronize];
    NSMutableDictionary * config = nil;
    if (self.txf_tags.text.length) {
        config = [@{@"elva-custom-metadata":@{
                            @"elva-tags":self.txf_tags.text,
                            @"testKey":@"testValue",
                            @"vip":@"vip1",
                            @"coins":@"0"}
                    } mutableCopy];
    }
    if (show) {
        if (!config) {
            config = [NSMutableDictionary dictionary];
        }
        //一、联系我们按钮显示逻辑
        //1、默认：FAQ列表页和详情页不显示，点击“踩”，显示联系我们按钮
        //2、永不显示：设置hideContactButtonFlag字段
        //3、一直显示：设置showContactButtonFlag
        switch (self.sc_show.selectedSegmentIndex) {
            case 0:break;
            case 1:[config setObject:@"1" forKey:@"showContactButtonFlag"];break;
            case 2:[config setObject:@"1" forKey:@"hideContactButtonFlag"];break;
        }
        //二、点击联系我们按钮（经过一步骤，显示了联系我们按钮的前提）进入客服页面的逻辑
        //1、默认：进入机器人页面（无人工客服入口按钮）
        //2、进入机器人页面+人工客服入口按钮：设置showContactButtonFlag
        //3、直接进入人工页面：设置directConversation
        switch (self.sc_logic.selectedSegmentIndex) {
            case 0:break;
            case 1:[config setObject:@"1" forKey:@"directConversation"];break;
            case 2:[config setObject:@"1" forKey:@"showConversationFlag"];break;
        }
    }
    return config;
}
#pragma mark - ACTION
///切换语言
- (void)onClickShowLanguageList {
    UIViewController * vc = [[XYLanguageController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
///人工客服
-(void)onClickShowPersonChat{
    [ECServiceSdk setUserName:self.txf_uname.text];
    [ECServiceSdk showConversation:self.txf_uid.text
                          ServerId:self.txf_serverid.text
                            Config:[self parserConfigDictionaryWithRightButtonIsShow:NO]];
}
///Rebot客服
- (void)onClickShowRebotChat {
    [ECServiceSdk showElva:self.txf_uname.text
                 PlayerUid:self.txf_uid.text
                  ServerId:self.txf_serverid.text
             PlayerParseId:self.txf_ppid.text
PlayershowConversationFlag:self.sc_logic.selectedSegmentIndex>0?@"1":@"0"
                    Config:[self parserConfigDictionaryWithRightButtonIsShow:YES]];
}

///FAQ网页版
- (void)onClickShowWebFAQ {
    NSMutableDictionary * config = [self parserConfigDictionaryWithRightButtonIsShow:NO];
    [ECServiceSdk showFAQSection:@"20476" Config:config];
}
///FAQ本地版
-(void)onClickShowLocalFAQ {
    NSMutableDictionary * config = [self parserConfigDictionaryWithRightButtonIsShow:YES];
    [ECServiceSdk showFAQs:self.txf_uname.text
                 playerUid:self.txf_uid.text
                    config:config];
}
///
- (void)onClickShowSingleFAQ {
    NSMutableDictionary * config = [self parserConfigDictionaryWithRightButtonIsShow:YES];
    [ECServiceSdk setUserName:self.txf_uname.text];
    [ECServiceSdk setUserId:self.txf_uid.text];
    [ECServiceSdk setServerId:self.txf_serverid.text];
    [ECServiceSdk showSingleFAQ:@"69147" Config:config];
}
///打开运营模块
-(void)onClickShowOperateModule {
    [ECServiceSdk showElvaOP:self.txf_uname.text
                   PlayerUid:self.txf_uid.text
                    ServerId:self.txf_serverid.text
               PlayerParseId:self.txf_ppid.text
  PlayershowConversationFlag:self.sc_logic.selectedSegmentIndex>0?@"1":@"0"
                      Config:[self parserConfigDictionaryWithRightButtonIsShow:NO]];
}

///打开某个网页链接
-(void)onClickShowWebURL {
    [ECServiceSdk showURL:@"https://github.com/AI-HELP/AIHelp-iOS-SDK"];
}

- (void)onClickSetVIP {
    [ECServiceSdk setVIP:self.txf_uname.text
                  userId:self.txf_uid.text
                  config:[self parserConfigDictionaryWithRightButtonIsShow:NO]];
}



@end
