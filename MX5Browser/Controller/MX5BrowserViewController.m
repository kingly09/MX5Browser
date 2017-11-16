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
#import "MX5BrowserURLCache.h"
#import "MX5BottomToolBar.h"

@interface MX5BrowserViewController ()<MX5WebViewDelegate>
@property (nonatomic, strong) MX5WebView *webView;
@property (nonatomic, strong) MX5BottomToolBar *bottomToolBar;

//返回按钮
@property (nonatomic) UIBarButtonItem *customBackBarItem;
//关闭按钮
@property (nonatomic) UIBarButtonItem *closeButtonItem;

@end

@implementation MX5BrowserViewController

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initializeView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
     self.navigationController.navigationBarHidden = NO;
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
    
    MX5BrowserURLCache *urlCache = (MX5BrowserURLCache *)[NSURLCache sharedURLCache];
    [urlCache removeAllCachedResponses];
}

- (void)dealloc {
    
    DDLogDebug(@" MX5BrowserViewController dealloc ");
}

#pragma mark - 初始化数据

-(void)initializeView {
    
  [self navigationItemView];
    
    self.bottomToolBar = [[MX5BottomToolBar alloc] initWithFrame:CGRectMake(0, KScreenHeight - KBOTTOM_TOOL_BAR_HEIGHT, KScreenWidth, KBOTTOM_TOOL_BAR_HEIGHT) withParentview:self.view];
    self.bottomToolBar.userInteractionEnabled = YES;
    [self.view addSubview:self.bottomToolBar];
    
    if (_isHideBottomToolBar == YES) {
        self.bottomToolBar.hidden = YES;
    }else{
        
        if (_menuList.count > 0) {
             [self.bottomToolBar reloadMenuView:_menuList];
        }
    }

}

/**
 初始化WebView
 */
-(void)setupWebView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    float bottomToolBarHight = (_isHideBottomToolBar == YES)?0:KBOTTOM_TOOL_BAR_HEIGHT;
    self.webView = [[MX5WebView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight+kNavBarHeight, KScreenWidth, KScreenHeight-(kStatusBarHeight+kNavBarHeight) - bottomToolBarHight)];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
}

-(void)navigationItemView{
    
    //添加右边刷新按钮
    UIBarButtonItem *roadLoad = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(roadLoadClicked)];
    self.navigationItem.rightBarButtonItem = roadLoad;
}

-(void)loadViewData {
    
    
}

// 网页缓存设置
-(void) webViewCache {
    //网页缓存设置
    MX5BrowserURLCache *urlCache = [[MX5BrowserURLCache alloc] initWithMemoryCapacity:20 * 1024 * 1024
                                                                 diskCapacity:200 * 1024 * 1024
                                                                     diskPath:nil
                                                                    cacheTime:0];
    [MX5BrowserURLCache setSharedURLCache:urlCache];
    
}

#pragma mark - 点击事件

/**
 重新加载网页
 */
- (void)roadLoadClicked{
    
    [self.webView reload];
}

/**
 返回上一个网页
 */
- (void)customBackItemClicked{
    
    if (self.webView.canGoBack) {
        [self.webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/**
 点击关闭web视图
 */
-(void)closeItemClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - MX5WebViewDelegate

/**
 webView开始加载
 */
- (void)webViewDidStartLoad:(MX5WebView *)webView {
    
}
/**
 webView加载完成
 */
- (void)webViewDidFinishLoad:(MX5WebView *)webView {
    self.title = webView.title;
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
    
    if (webView.canGoBack) {
        UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spaceButtonItem.width = -6.5;
        [self.navigationItem setLeftBarButtonItems:@[spaceButtonItem,self.customBackBarItem,self.closeButtonItem] animated:NO];
    }else{
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        [self.navigationItem setLeftBarButtonItems:@[self.customBackBarItem]];
    }
}
/**
 更新web视图的title
 */
- (void)updateWebViewTitle:(MX5WebView *)webView {
     self.title = webView.title;
}

#pragma mark - 初始化URL/对外扩展方法

- (void)loadWebURLSring:(NSString *)urlString {
    //初始化WebView
    [self setupWebView];
    //加载数据
    [self loadViewData];
    
    //初始化视图
    [self initializeView];
    
    [self.webView loadWebURLSring:urlString];
}

#pragma mark - setter and getter 方法
#pragma mark - 懒加载

-(UIBarButtonItem *)customBackBarItem{
    if (!_customBackBarItem) {
        UIImage* backItemImage = [[UIImage imageNamed:@"m_ic_left"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImage* backItemHlImage = [[UIImage imageNamed:@"m_ic_left"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        UIButton* backButton = [[UIButton alloc] init];
        [backButton adjustsImageWhenHighlighted];
        [backButton adjustsImageWhenDisabled];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton setTitleColor:self.navigationController.navigationBar.tintColor forState:UIControlStateNormal];
        [backButton setTitleColor:[self.navigationController.navigationBar.tintColor colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
        [backButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
        [backButton setImage:backItemImage forState:UIControlStateNormal];
        [backButton setImage:backItemHlImage forState:UIControlStateHighlighted];
        [backButton sizeToFit];
        
        [backButton addTarget:self action:@selector(customBackItemClicked) forControlEvents:UIControlEventTouchUpInside];
        _customBackBarItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    }
    return _customBackBarItem;
}

-(UIBarButtonItem *)closeButtonItem{
    if (!_closeButtonItem) {
        _closeButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeItemClicked)];
    }
    return _closeButtonItem;
}

@end
