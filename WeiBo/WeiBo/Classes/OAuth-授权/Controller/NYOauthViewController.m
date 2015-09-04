//
//  NYOauthViewController.m
//  WeiBo
//
//  Created by Apple on 15/9/4.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "NYOauthViewController.h"
#import "NYHTTPSessionManager.h"
#import "NYAccount.h"
#import <SVProgressHUD.h>
#import "NYTabBarController.h"
#import "NYNewFeatureViewController.h"
#import <MJExtension.h>
#import "NYAccountTool.h"

@interface NYOauthViewController ()<UIWebViewDelegate>

@end

@implementation NYOauthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webview = [[UIWebView alloc]initWithFrame:self.view.bounds];
    webview.delegate = self;
    [self.view addSubview:webview];
    
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=4254728050&redirect_uri=http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webview loadRequest:request];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [SVProgressHUD showWithStatus:@"正在加载..."];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    /**
     *  获取url;判断是否为回调地址;利用code获取devicetoken
     */
    
    NSString *url = request.URL.absoluteString;
    NSRange range = [url rangeOfString:@"code="];
    if (range.length !=0) {
        NSInteger fromIndex = range.location + range.length;
        NSString *code = [url substringFromIndex:fromIndex];
        [self accessTokenWithCode:code];
        
    }
    return YES;
}
- (void)accessTokenWithCode:(NSString *)code
{
    NYHTTPSessionManager *manager = [NYHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"4254728050";
    params[@"client_secret"] = @"6f3427c5f77c7643457ec2fe73d7654c";
    params[@"grant_type"] = @"authorization_code";
    params[@"redirect_uri"] = @"http://www.baidu.com";
    params[@"code"] = code;

    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(NSURLSessionDataTask * task, id responseObject) {
        [SVProgressHUD dismiss];
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];

        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *path = [doc stringByAppendingPathComponent:@"account.archive"];
        
        NYAccount *account = [NYAccount objectWithKeyValues:dict];
        [NYAccountTool saveAccount:account];
        
        [NSKeyedArchiver archiveRootObject:account toFile:path];
        
        NSString *key = @"CFBundleVersion";
        NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
        NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        if ([lastVersion isEqualToString: currentVersion]) {
            window.rootViewController = [[NYTabBarController alloc]init];
        } else {
    
            window.rootViewController = [[NYNewFeatureViewController alloc]init];
            [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        

    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        NSLog(@"请求失败,%@",error);

    }];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [SVProgressHUD dismiss];
}
@end
