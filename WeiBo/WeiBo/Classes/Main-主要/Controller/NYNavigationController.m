//
//  NYNavigationController.m
//  WeiBo
//
//  Created by Apple on 15/8/28.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "NYNavigationController.h"

@interface NYNavigationController ()

@end

@implementation NYNavigationController

+ (void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    attrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    [bar setTitleTextAttributes:attrs];

    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
    NSMutableDictionary *itemattrs = [NSMutableDictionary dictionary];
    itemattrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    itemattrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:itemattrs forState:UIControlStateNormal];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        UIButton *leftbutton = [self setupBarButtonWithImage:[UIImage imageNamed:@"navigationbar_back"] HighlightedImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] title:nil];
        [leftbutton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftbutton];
        UIButton *rightbutton = [self setupBarButtonWithImage:[UIImage imageNamed:@"navigationbar_more"] HighlightedImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] title:nil];
        [rightbutton addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightbutton];
    }
    [super pushViewController:viewController animated:animated];


}
- (UIButton *)setupBarButtonWithImage:(UIImage *)image HighlightedImage:(UIImage *)highlightedImage title:(NSString *)titlename
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:highlightedImage forState:UIControlStateHighlighted];
    [button setTitle:titlename forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button sizeToFit];
    return button;
    
}
- (void)backClick
{
    [self popViewControllerAnimated:YES];
}
- (void)rightClick
{
    [self popToRootViewControllerAnimated:YES];
}
@end
