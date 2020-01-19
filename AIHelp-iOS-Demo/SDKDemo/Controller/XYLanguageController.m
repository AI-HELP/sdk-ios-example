
#import "XYLanguageController.h"
#import <ElvaChatServiceSDK/ElvaChatServiceSDK.h>

@implementation XYLanguageController
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.title = [NSString stringWithFormat:@"当前（%@）",[AliceTools getUserLanguage]];
    self.dataArray = @[@[@"ar",@"阿拉伯语"],
                       @[@"de",@"德语"],
                       @[@"el",@"希腊语"],
                       @[@"en",@"英语"],
                       @[@"es",@"西班牙语"],
                       @[@"fa",@"法斯语"],
                       @[@"fr",@"法语"],
                       @[@"id",@"印度尼西亚语"],
                       @[@"it",@"意大利语"],
                       @[@"ja",@"日语"],
                       @[@"ko",@"韩语"],
                       @[@"pl",@"波兰语"],
                       @[@"pt",@"葡萄牙语"],
                       @[@"ru",@"俄语"],
                       @[@"sv",@"瑞典语"],
                       @[@"th",@"泰语"],
                       @[@"tr",@"土耳其语"],
                       @[@"vi",@"越南语"],
                       @[@"zh-Hans",@"中文简体"],
                       @[@"zh-Hant",@"中文繁体"]];
    
    
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 40)];
    self.textField = [[UITextField alloc] initWithFrame:self.tableView.tableHeaderView.bounds];
    self.textField.delegate = self;
    self.textField.borderStyle = UITextBorderStyleBezel;
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.tableView.tableHeaderView addSubview:self.textField];
    self.textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"切换" style:UIBarButtonItemStyleDone target:self action:@selector(onClickNaivationBarItem:)];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (!cell) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"];
    NSString * language = [self.dataArray[indexPath.row] lastObject];
    NSString * code = [self.dataArray[indexPath.row] firstObject];
    cell.textLabel.text = [NSString stringWithFormat:@"%@(%@)",language,code];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString * code = [self.dataArray[indexPath.row] firstObject];
    [ECServiceSdk setSDKLanguage:code];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onClickNaivationBarItem:(UIBarButtonItem*)item {
    if (self.textField.text.length) {
        [ECServiceSdk setSDKLanguage:self.textField.text];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
@end
