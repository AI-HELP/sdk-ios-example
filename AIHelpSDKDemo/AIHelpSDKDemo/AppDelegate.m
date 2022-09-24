//
//  AppDelegate.m
//  AIHelpSDKDemo
//
//  Created by AIHelp on 2020/10/10.
//

#import "AppDelegate.h"
#import "AITabBarController.h"
#import <AIHelpSupportSDK/AIHelpSupportSDK.h>
#import <MBProgressHUD.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window.rootViewController = [[AITabBarController alloc] init];
    [self initAIHelpSDK];
    [self.window makeKeyAndVisible];
    [self startLoading];
    return YES;
}

void AIHelp_onInitializationCallback() {
    MBProgressHUD *hud = (MBProgressHUD *)[[UIApplication sharedApplication].windows.firstObject viewWithTag:12345];
    hud.label.text = @"Everything is prepared now.";
    [hud hideAnimated:YES afterDelay:1.5];
}

- (void)initAIHelpSDK
{
    [AIHelpSupportSDK enableLogging:YES];
    [AIHelpSupportSDK initWithApiKey:@"TryElva_platform_09ebf7fa-8d45-4843-bd59-cfda3d8a8dc0"
                              domainName:@"release.aihelp.net"
                                      appId:@"xx_platform_efbc5231bc71459444d69cb489d9a7d2"
                                   language:@"zh_CN"];
    [AIHelpSupportSDK setOnInitializedCallback:AIHelp_onInitializationCallback];
}

- (void)startLoading
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = @"Be patient, loading AIHelp..";
    hud.tag = 12345;
    [hud hideAnimated:YES afterDelay:10];
}







@end
