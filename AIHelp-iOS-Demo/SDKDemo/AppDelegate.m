
#import "AppDelegate.h"
#import "ViewController.h"
#import <ElvaChatServiceSDK/ElvaChatServiceSDK.h>

/*
 * notify the application when some state changes in Elva.
 * eventCode:
 *    2: Elva UI Visible Changed
 *          state (0) : will show elva ui
 *          state (1) : all elva ui are closed
 */
void ECService_onEventChanged(const int eventCode, const int state) {
    NSLog(@"ECService::onEventChanged(%d, %d)\n", eventCode, state);
}

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [ECServiceSdk setEventListener:ECService_onEventChanged];
    [ECServiceSdk setOpenLog:YES];
    [ECServiceSdk init:@"input your app key at here"
                Domain:@"input your app domain at here"
                 AppId:@"input your app id at here"];
    // (CN) 注：
    // 上面这三个参数，请使用注册时的邮箱地址作为登录名登录 [AIHelp 客服后台] (https://aihelp.net/elva)。
    //    在Settings菜单Applications页面查看。
    //    初次使用，请先登录[AIHelp 官网](http://aihelp.net/index.html) 自助注册。<br />
    // (EN) Note:
    // Please log into [AIHelp Web Console](https://aihelp.net/elva)
    // with your registered email account to find the `APP Key`, `Domain` and `Platforms(AppID)`
    // In the _Application_ page of the _Settings_ Menu.
    // If your company doesn't have an account, you need to register an account at [AIHelp Website](http://aihelp.net/index.html)
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    UIViewController * vc = [[ViewController alloc] init];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.window makeKeyAndVisible];
    return YES;
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    return UIInterfaceOrientationMaskAll;
}

@end
