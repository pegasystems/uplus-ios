//
// Copyright (c) 2016 and Confidential to Pegasystems Inc. All rights reserved.
//

#import "MainTabBarController.h"

@class UITabBarButton;
@interface MainTabBarController () <UITabBarControllerDelegate>

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;

    // generate selection indicator image
    CGFloat width = self.tabBar.frame.size.width / [self.tabBar.items count];
    CGFloat height = self.tabBar.frame.size.height;
    CGSize size = CGSizeMake(width, height);
    UIGraphicsBeginImageContext(size);
    [[UIColor colorWithRed:0.37 green:0.80 blue:0.96 alpha:1.0] setFill];
    UIRectFill(CGRectMake(0, 0, width, height));
    UIImage *bg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.tabBar.selectionIndicatorImage = bg;

    [UITabBarItem.appearance setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] } forState:UIControlStateNormal];

    for (UITabBarItem *item in [self.tabBar items]) {
        item.image = [item.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.selectedImage = [item.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    return NO;
}

@end
