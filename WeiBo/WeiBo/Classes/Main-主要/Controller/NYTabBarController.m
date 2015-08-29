//
//  NYTabBarController.m
//  WeiBo
//
//  Created by Apple on 15/8/28.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "NYTabBarController.h"
#import "NYHomeViewController.h"
#import "NYMessageViewController.h"
#import "NYDiscoverViewController.h"
#import "NYProfileViewController.h"
#import "NYTabBar.h"
#import "NYNavigationController.h"

@interface NYTabBarController ()

@end

@implementation NYTabBarController

+ (void)initialize
{
    
    UITabBarItem *tabBaritem = [UITabBarItem appearanceWhenContainedIn:self, nil];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    [tabBaritem setTitleTextAttributes:attrs forState:UIControlStateNormal];
    
    NSMutableDictionary *selattrs = [NSMutableDictionary dictionary];
    selattrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [tabBaritem setTitleTextAttributes:selattrs forState:UIControlStateSelected];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildrenVC];
    [self setupTabBar];
}
- (void)setupTabBar
{
    [self setValue:[[NYTabBar alloc]init] forKeyPath:@"tabBar"];
}
- (void)setupChildrenVC
{
    NYHomeViewController *home = [[NYHomeViewController alloc]init];
    [self setupOneChildViewController:home image:[UIImage imageNamed:@"tabbar_home"] selimage:[UIImage imageNamed:@"tabbar_home_selected"]title:@"首页"];
    
    NYMessageViewController *message = [[NYMessageViewController alloc]init];
    [self setupOneChildViewController:message image:[UIImage imageNamed:@"tabbar_message_center"] selimage:[UIImage imageNamed:@"tabbar_message_center_selected"]title:@"消息"];
    
    NYDiscoverViewController *discover = [[NYDiscoverViewController alloc]init];
    [self setupOneChildViewController:discover image:[UIImage imageNamed:@"tabbar_discover"] selimage:[UIImage imageNamed:@"tabbar_discover_selected"]title:@"发现"];
    
    NYProfileViewController *profile = [[NYProfileViewController alloc]init];
    [self setupOneChildViewController:profile image:[UIImage imageNamed:@"tabbar_profile"] selimage:[UIImage imageNamed:@"tabbar_profile_selected"]title:@"我"];
    
}
- (void)setupOneChildViewController:(UIViewController *)vc image:(UIImage *)image selimage:(UIImage *)selimage title:(NSString *)titlename
{
    vc.title = titlename;
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = [selimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    NYNavigationController *nav = [[NYNavigationController alloc]initWithRootViewController:vc];
    [self addChildViewController:nav];
}
@end
