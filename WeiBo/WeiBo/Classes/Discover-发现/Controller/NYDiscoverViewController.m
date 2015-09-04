//
//  NYDiscoverViewController.m
//  WeiBo
//
//  Created by Apple on 15/8/28.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "NYDiscoverViewController.h"
#import "NYSearchBar.h"
@interface NYDiscoverViewController ()<UITextFieldDelegate>

@end

@implementation NYDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
}
- (void)setupNav
{
    NYSearchBar *searchbar = [NYSearchBar searchBar];
    searchbar.width = 300;
    searchbar.height = 30;
    searchbar.delegate = self;
    self.navigationItem.titleView = searchbar;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"%s",__func__);
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"%s,%@",__func__,textField.text);
    [self.view endEditing:YES];
    [textField resignFirstResponder];
    return YES;
}
@end
