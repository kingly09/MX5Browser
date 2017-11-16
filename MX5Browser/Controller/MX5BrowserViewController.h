//
//  MX5BrowserViewController.h
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

NS_ASSUME_NONNULL_BEGIN

/**
 请求方式

 - MX5WebViewTypeWebURLString: 请求网路链接
 - MX5WebViewTypeLocalHTMLString: 请求本地html文件
 - MX5WebViewTypeAutomaticLogin: 请求带填登录
 - MX5WebViewTypeHTMLString: 请求html字符串或本地html字符串
 */
typedef NS_ENUM(NSUInteger, MX5WebViewType){
    MX5WebViewTypeWebURLString = 0,
    MX5WebViewTypeLocalHTMLString = 1,
    MX5WebViewTypeAutomaticLogin = 2,
    MX5WebViewTypeHTMLString= 3
};


@class MX5WebView;
/**
 整个浏览器的主框架
 */
@interface MX5BrowserViewController : UIViewController

@property (nonatomic) BOOL isHideBottomToolBar;  //是否隐藏底部导航条
@property (nonatomic,strong) NSArray *menuList;  //底部菜单数组
/**
 加载纯外部链接网页
 
 @param urlString URL地址
 */
- (void)loadWebURLSring:(NSString *)urlString;

NS_ASSUME_NONNULL_END

@end
