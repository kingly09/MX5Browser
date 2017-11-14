//
//  MX5BrowserViewController.m
//  MX5BrowserOC
//
//  Created by kingly on 2017/11/10.
//  Copyright © 2017年 MX5Browser Software https://github.com/kingly09/MX5Browser  by kingly inc.  

//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE. All rights reserved.
//

#import "MX5BrowserViewController.h"
#import "MX5Browser.h"
#import "MX5WebView.h"

@interface MX5BrowserViewController ()<MX5WebViewDelegate>
@property (nonatomic, strong) MX5WebView *webView;
@end

@implementation MX5BrowserViewController

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
   
}
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:YES];
}


-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    DDLogDebug(@" MX5BrowserViewController dealloc ");
}

#pragma mark - 初始化数据
/**
 初始化WebView
 */
-(void)setupWebView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.webView = [[MX5WebView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight+kNavBarHeight, KScreenWidth, KScreenHeight-(kStatusBarHeight+kNavBarHeight))];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
}

-(void)loadViewData {
    
    
}


#pragma mark - Navigation

/**
 webView开始加载
 */
- (void)webViewDidStartLoad:(MX5WebView *)webView {
    
}
/**
 webView加载完成
 */
- (void)webViewDidFinishLoad:(MX5WebView *)webView {
    
}
/**
 加载webView失败
 
 @param webView MX5WebView
 @param error 失败消息
 */
- (void)webView:(MX5WebView *)webView didFailLoadWithError:(NSError *)error {
    
    
}
/**
 更新导航条
 */
- (void)updateNavigationItems:(MX5WebView *)webView {
    
}

#pragma mark - 初始化URL/对外扩展方法

- (void)loadWebURLSring:(NSString *)urlString {
    //初始化WebView
    [self setupWebView];
    //加载数据
    [self loadViewData];
    
    [self.webView loadWebURLSring:urlString];
}

@end
