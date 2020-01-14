
#import "AppDelegate.h"
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

@interface AppDelegate ()

@end

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
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
