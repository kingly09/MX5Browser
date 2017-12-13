//
//  MX5WebView.h
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

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 MX5共享一个pool 用以cookies共享
 */
@interface MX5BrowserProcessPool : NSObject

+ (instancetype)sharedInstance;

- (WKProcessPool *)defaultPool;

@end

@class MX5WebView;
@protocol MX5WebViewDelegate <NSObject>

@optional
/**
 webView开始加载
 */
- (void)webViewDidStartLoad:(MX5WebView *)webView;
/**
 webView加载完成
 */
- (void)webViewDidFinishLoad:(MX5WebView *)webView;
/**
 加载webView失败

 @param webView MX5WebView
 @param error 失败消息
 */
- (void)webView:(MX5WebView *)webView didFailLoadWithError:(NSError *)error;
/**
 更新导航条
 */
- (void)updateNavigationItems:(MX5WebView *)webView;
/**
 更新web视图的title
 */
- (void)updateWebViewTitle:(MX5WebView *)webView;

/**
 接受js 传递过来的消息
 @param webView MX5WebView
 @param receiveScriptMessage receiveScriptMessage  字典类型的消息体
 */
- (void)webView:(MX5WebView *)webView didReceiveScriptMessage:(NSDictionary *)receiveScriptMessage;


@end

/**
 基于WKWebView的网页的渲染与展示
 */
@interface MX5WebView : UIView <WKNavigationDelegate,WKUIDelegate,UIScrollViewDelegate>

@property (nonatomic, weak) id<MX5WebViewDelegate> delegate;
/**
 当内部使用的时候
 */
@property (nonatomic, readonly) WKWebView *wkWebView;
/**
 当前滚动视图
 */
@property (nonatomic, readonly, weak) UIScrollView *scrollView;
// 网页标题
@property (nonatomic, readonly, copy) NSString *title;
// 请求网页Url
@property (nonatomic, readonly, copy) NSString *URLString;
// 当前网页Url
@property (nonatomic, readonly, copy) NSString *currUrl;

@property (nonatomic, readonly, getter=isLoading) BOOL loading;

@property (nonatomic, readonly) BOOL canGoBack;
@property (nonatomic, readonly) BOOL canGoForward;


/**
 加载纯外部链接网页
 
 @param urlString URL地址
 */
- (void)loadWebURLSring:(NSString *)urlString;
/**
 加载本地HTML

 @param string HTML字符串
 @param baseURL  bundleURL
 */
- (void)loadHTMLString:(NSString *)string baseURL:(nullable NSURL *)baseURL;

/**
 注入javaScript代码

 @param javaScriptString js代码
 */
- (void)evaluateJavaScript:(NSString *)javaScriptString;

/**
 添加一个添加js消息处理

 */
- (void)addScriptMessageHandlerName:(NSString *)scriptMessageHandlerName;


- (id)goBack;
- (id)goForward;

- (id)reload;
- (id)reloadFromOrigin;

- (void)stopLoading;


- (void)deallocWebView;


// 清除缓存
+ (void)removeCache;

NS_ASSUME_NONNULL_END

@end
