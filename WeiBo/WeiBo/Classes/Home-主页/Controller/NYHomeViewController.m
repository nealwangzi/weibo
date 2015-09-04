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

@interface NYHomeViewController ()<NYDropdownMenuDelegate>
/* titleview */
@property(nonatomic , weak) NYTitleViewButton *titleButtonView;

@end

@implementation NYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
    [self setupUserInfo];
}
- (void)setupUserInfo
{
    NYHTTPSessionManager *manager = [NYHTTPSessionManager manager];
    
    NYAccount *account = [NYAccountTool account];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    [manager GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(NSURLSessionDataTask * task, id responseObject) {
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
