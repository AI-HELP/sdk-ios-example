//
//  AITabBarController.m
//  AIHelpSDKDemo
//
//  Created by AIHelp on 2020/10/21.
//

#import "AITabBarController.h"

@interface AITabBarController ()

@end

@implementation AITabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *controllerArray = @[
        @{@"vc":@"ModeViewController",@"image":@"",@"selectImage":@"",@"title":@"mode"},
        @{@"vc":@"SettingViewController",@"image":@"",@"selectImage":@"",@"title":@"setting"},
        @{@"vc":@"OtherViewController",@"image":@"",@"selectImage":@"",@"title":@"other"}
    ];
    NSMutableArray *navArray = [NSMutableArray array];
    for (NSDictionary *dic in controllerArray) {
        UIViewController *viewController = [[NSClassFromString(dic[@"vc"]) alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
        nav.tabBarItem.title = dic[@"title"];
        nav.tabBarItem.image = [[UIImage imageNamed:dic[@"image"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        nav.tabBarItem.selectedImage = [[UIImage imageNamed:dic[@"selectImage"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [navArray addObject:nav];
    }
    
    self.viewControllers = navArray;
    self.tabBar.translucent = NO;
    
}



@end
