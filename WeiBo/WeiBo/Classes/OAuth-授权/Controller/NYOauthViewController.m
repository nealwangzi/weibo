//
//  NYOauthViewController.m
//  WeiBo
//
//  Created by Apple on 15/9/4.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "NYOauthViewController.h"
#import "NYHTTPSessionManager.h"
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
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
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
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"请求成功,%@",dict);
        
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        NSLog(@"请求失败,%@",error);

    }];
}
@end
