//
//  MX5WebView.m
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

#import "MX5WebView.h"
#import "MX5Browser.h"

@interface MX5BrowserProcessPool()
@property (nonatomic, strong) WKProcessPool *pool;
@end

@implementation MX5BrowserProcessPool

+ (instancetype)sharedInstance{
    static id sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance= [[self alloc] initPrivate];
    });
    return sharedInstance;
}

- (instancetype)initPrivate
{
    self = [super init];
    if (self) {
        self.pool = [WKProcessPool new];
    }
    return self;
}

- (WKProcessPool *)defaultPool{
    return self.pool;
}

@end

@interface MX5WebView()

//设置加载进度条
@property (nonatomic,strong) UIProgressView *progressView;

@property (nonatomic, strong) NSURLRequest *originRequest;
@property (nonatomic, strong) NSURLRequest *request;

@end

@implementation MX5WebView

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self initWKWebView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self){
        [self initWKWebView];
    }
    return self;
}

/**
 初始化WKWebView视图
 */
-(void)initWKWebView {
    
    [self setFrame:self.bounds];
    [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    
    // 设置代理
    self.navigationDelegate = self;
    self.UIDelegate = self;
    self.scrollView.delegate = self;
    
}

-(void)dealloc {
    
    DDLogDebug(@"MX5WebView dealloc");
    
}

#pragma mark - 对外接口

-(UIScrollView *)scrollView {
    return [self scrollView];
}



#pragma mark - Cookie有关

- (void)injectCookies:(NSMutableURLRequest *)request{
    [self resetCookieForHeaderFields:request];
    [self addUserCookieScript:request];
}

// 修改请求头的Cookie
- (void)resetCookieForHeaderFields:(NSMutableURLRequest *)request{
    NSArray *cookies = [self currentCookies:request];
    NSDictionary *requestHeaderFields = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
    request.allHTTPHeaderFields = requestHeaderFields;
}

// 获取当前域名下的cookie
- (NSArray *)currentCookies:(NSMutableURLRequest *)request{
    NSArray *cookies = [NSHTTPCookieStorage sharedHTTPCookieStorage].cookies;
    NSString *validDomain = request.URL.host;
    NSMutableArray *mutableArr = [NSMutableArray array];
    for (NSHTTPCookie *cookie in cookies) {
        if (![validDomain hasSuffix:cookie.domain]) {
            continue;
        }
        [mutableArr addObject:cookie];
    }
    return mutableArr;
}

// 通过脚本出入cookie
- (void)addUserCookieScript:(NSURLRequest *)request{
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    if (!cookies || cookies.count < 1) {
        return;
    }
    NSString *cookieScript = [self injectLocalCookieScript];
    WKUserScript *startScript = [[WKUserScript alloc]initWithSource:cookieScript injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
    [self.configuration.userContentController addUserScript:startScript];
}

- (NSString *)injectLocalCookieScript{
    NSString *jsString = kInjectLocalCookieScript;
    NSMutableString *cookieScript = [NSMutableString stringWithString:jsString];
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for (NSHTTPCookie *cookie in cookies) {
        if ([cookie.name isEqualToString:@"jk"]) {//不添加本地jk，一般页面会写入jk
            continue;
        }
        NSString *name = cookie.name ?: @"";
        NSString *value = cookie.value ?: @"";
        NSString *domain = cookie.domain ?: @"";
        NSString *path = cookie.path ?: @"/";
        NSString *secure = cookie.secure ?@"true": @"false";
        NSInteger days = 1;
        if (cookie.expiresDate) {
            NSTimeInterval seconds = [cookie.expiresDate timeIntervalSinceNow];
            days = seconds/3600/24;
        }
        [cookieScript appendString:[NSString stringWithFormat:@"setCookieFromApp('%@', '%@', %ld, '%@','%@', %@);",name,value,(long)days,path,domain,secure]];
    }
    return cookieScript;
}

//防止Cookie丢失
- (NSURLRequest *)fixRequest:(NSURLRequest *)request{
    NSMutableURLRequest *fixedRequest;
    if ([request isKindOfClass:[NSMutableURLRequest class]]) {
        fixedRequest = (NSMutableURLRequest *)request;
    } else {
        fixedRequest = request.mutableCopy;
    }
    NSDictionary *dict = [NSHTTPCookie requestHeaderFieldsWithCookies:[self currentCookies:fixedRequest]];
    if (dict.count) {
        NSMutableDictionary *mDict = request.allHTTPHeaderFields.mutableCopy;
        [mDict setValuesForKeysWithDictionary:dict];
        fixedRequest.allHTTPHeaderFields = mDict;
    }
    return fixedRequest;
}

/**
 添加Cookie
 @param completion 回调
 */
- (void)evaluateJavaScriptToAddCookie:(void(^)(void))completion{
    NSString *cookieScript = [self injectLocalCookieScript];
    [self evaluateJavaScript:cookieScript completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        completion();
    }];
}


@end
