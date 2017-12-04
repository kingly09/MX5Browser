//
//  MX5WebViewJavascriptBridge.m
//  MX5BrowserOC
//
//  Created by kingly on 2017/12/4.
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

#import "MX5WebViewJavascriptBridge.h"

@interface MX5WebViewJavascriptBridge()

@property (nonatomic, weak) UIViewController *vc;
@end

@implementation MX5WebViewJavascriptBridge

- (instancetype)initWithDelegate:(id<MX5WebViewJavascriptBridgeDelegate>)delegate vc:(UIViewController *)vc; {
    if (self = [super init]) {
        self.delegate = delegate;
        self.vc = vc;
    }
    return self;
}

- (void)dealloc {
    NSLog(@"MX5WebViewJavascriptBridge dealloc  %@, %s", self.class, __func__);
}

#pragma mark - WKScriptMessageHandler 拦截执行网页中的JS方法

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:message.body];
    NSLog(@"JS交互参数：%@", dic);
    //服务器固定格式写法 window.webkit.messageHandlers.名字.postMessage(内容);
    //客户端写法 message.name isEqualToString:@"名字"]
    if ([message.name isEqualToString:KWebGetDeviceID] && [dic isKindOfClass:[NSDictionary class]] ) {
        
        NSLog(@"currentThread  ------   %@", [NSThread currentThread]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if(_delegate && [_delegate respondsToSelector:@selector(MX5WebViewJavascriptBridgeDidReceiveScriptMessage:)]){
                [self.delegate MX5WebViewJavascriptBridgeDidReceiveScriptMessage:dic];
            }
            
        });
    } else {
        return;
    }
}




@end
