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
    
    [AIHelpSupportSDK initWithApiKey:@"THIS IS YOUR APP KEY"
                              domainName:@"THIS IS YOUR DOMAIN"
                                      appId:@"THIS IS YOUR APP ID"
                                   language:@"THIS IS LANGUAGE"];
    [AIHelpSupportSDK setOnInitializedCallback:AIHelp_onInitializationCallback];
    [AIHelpSupportSDK enableLogging:NO];
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
