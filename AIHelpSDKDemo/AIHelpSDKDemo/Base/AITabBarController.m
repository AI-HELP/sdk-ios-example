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
        @{@"vc":@"ModeViewController",@"image":@"modeNormal",@"selectImage":@"modeSelected",@"title":@"mode"},
        @{@"vc":@"SettingViewController",@"image":@"settingNormal",@"selectImage":@"settingSelected",@"title":@"setting"},
        @{@"vc":@"OtherViewController",@"image":@"otherNormal",@"selectImage":@"otherSelected",@"title":@"other"}
    ];
    NSMutableArray *navArray = [NSMutableArray array];
    for (NSDictionary *dic in controllerArray) {
        UIViewController *viewController = [[NSClassFromString(dic[@"vc"]) alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
        nav.tabBarItem.title = dic[@"title"];
        nav.tabBarItem.image = [[UIImage imageNamed:dic[@"image"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        nav.tabBarItem.selectedImage = [[UIImage imageNamed:dic[@"selectImage"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self setTabBarItemColor:nav];
        [navArray addObject:nav];
    }
    
    self.viewControllers = navArray;
    self.tabBar.translucent = NO;
}

- (void)setTabBarItemColor:(UIViewController *)viewController {
    if (@available(iOS 13.0, *)) {
        UITabBarAppearance *appearance = [UITabBarAppearance new];
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor systemBlueColor]};
        viewController.tabBarItem.standardAppearance = appearance;
    } else {
        [viewController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor systemBlueColor]} forState:UIControlStateSelected];
    }
}

@end
