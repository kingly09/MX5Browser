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

/**
 基于WKWebView的网页的渲染与展示
 */
@interface MX5WebView : UIView <WKNavigationDelegate,WKUIDelegate,UIScrollViewDelegate>

/**
 当内部使用的时候
 */
@property (nonatomic, readonly) WKWebView *wkWebView;
/**
 当前滚动视图
 */
@property (nonatomic, readonly, weak) UIScrollView *scrollView;
/// 网页标题
@property (nonatomic, readonly, copy) NSString *title;

NS_ASSUME_NONNULL_END

@end
