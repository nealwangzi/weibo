//
//  NYHomeViewController.m
//  WeiBo
//
//  Created by Apple on 15/8/28.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "NYHomeViewController.h"
#import "NYTitleViewButton.h"
#import "NYDropdownMenu.h"
#import "NYDropdownMenuController.h"
#import "NYAccount.h"
#import "NYAccountTool.h"
#import "NYHTTPSessionManager.h"
#import <UIImageView+WebCache.h>

@interface NYHomeViewController ()<NYDropdownMenuDelegate>
/* titleview */
@property(nonatomic , weak) NYTitleViewButton *titleButtonView;
/* manager */
@property(nonatomic , strong) NYHTTPSessionManager *manager;
/* 微博内容 */
@property(nonatomic , strong) NSArray *status;

@end

@implementation NYHomeViewController
- (NYHTTPSessionManager *)manager
{
    if (_manager == nil) {
        _manager = [NYHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
    [self setupUserInfo];
    [self loadNewStatus];
}
- (void)loadNewStatus
{
    NYAccount *account = [NYAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;

    [self.manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^ (NSURLSessionDataTask * task, id responseObject) {
        self.status = responseObject[@"statuses"];
        NSLog(@"%@",self.status);
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        
    }];
}
- (void)setupUserInfo
{
    
    NYAccount *account = [NYAccountTool account];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    [self.manager GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(NSURLSessionDataTask * task, id responseObject) {
        NSString *name = responseObject[@"name"];
        [self.titleButtonView setTitle:name forState:UIControlStateNormal];
        account.name = name;
        [NYAccountTool saveAccount:account];
        
    } failure:^ (NSURLSessionDataTask * task, NSError * error) {
        NYLog(@"%@",error);
    }];
    
}
- (void)setupNavBar
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(rightbuttonClick) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(rightbuttonClick) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    
    NYTitleViewButton *titleButtonView = [[NYTitleViewButton alloc]init];
    NSString *name = [NYAccountTool account].name;
    [titleButtonView setTitle:name?name:@"首页" forState:UIControlStateNormal];
    [titleButtonView addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.titleView = titleButtonView;
    self.titleButtonView = titleButtonView;
}
- (void)rightbuttonClick
{
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)titleButtonClick:(UIButton *)button
{
    button.selected = !button.selected;
    
    NYDropdownMenu *popmenu = [NYDropdownMenu dropdownMenu];
    popmenu.delegate = self;
    NYDropdownMenuController *dropdownMenuVc = [[NYDropdownMenuController alloc]init];
    dropdownMenuVc.view.width= 150;
    dropdownMenuVc.view.height = 150;
    popmenu.contentViewController = dropdownMenuVc;
    [popmenu showFrom:button];

    
}
- (void)disMissdropdownMenu:(NYDropdownMenu *)dropdowmenu
{
    self.titleButtonView.selected = !self.titleButtonView.selected;
}
#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.status.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"status"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"status"];
    }
    NSDictionary *status = self.status[indexPath.row];
    NSDictionary *user = status[@"user"];
    cell.textLabel.text = user[@"name"];
    cell.detailTextLabel.text = status[@"text"];
    
    // 设置头像
    NSString *imageUrl = user[@"profile_image_url"];
    UIImage *placehoder = [UIImage imageNamed:@"avatar_default_small"];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:placehoder];

    return cell;
}
@end