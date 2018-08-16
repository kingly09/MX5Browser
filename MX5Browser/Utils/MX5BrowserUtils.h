//
//  MX5BrowserUtils.h
//  MX5BrowserOC
//
//  Created by kingly on 2017/11/14.
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

#import <Foundation/Foundation.h>

@interface MX5BrowserUtils : NSObject

/**
 获取当前URL的cookie信息
 
 @param urlstring 当前URL
 @return 返回当前URL的cookie信息
 */
+ (NSString *)getCurrHTTPCookie:(NSString *)urlstring;
/**
 可以app内打开的链接

 @param url URL链接
 */
+ (BOOL)canAppHandleURL:(NSURL *)url;

/**
 检查是否是合法的URL的字符串

 @param urlString 需要检查的URL字符串
 */
+ (BOOL)isURL:(NSString *)urlString;



@end
