//
//  NSString+MX5Browser.m
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


#import "NSString+MX5Browser.h"

static NSString * const kURLRegEx = @"((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";


@implementation NSString (MX5Browser)

- (BOOL)isValidURL{
    NSPredicate *urlPredic = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",kURLRegEx];
    return [urlPredic evaluateWithObject:self];
}

- (BOOL)isLocal{
    NSURL *url = [NSURL URLWithString:self];
    return [url.host.lowercaseString isEqualToString:@"localhost"] || [url.host isEqualToString:@"127.0.0.1"];
}

- (NSString *)ellipsizeWithMaxLength:(NSInteger)maxLength{
    if (maxLength >= 2 && self.length > maxLength) {
        NSInteger index1 = (maxLength + 1) / 2;
        NSInteger index2 = self.length - maxLength / 2;
        
        NSString *index1Str = [self substringToIndex:index1];
        NSString *index2Str = [self substringFromIndex:index2];
        
        return [NSString stringWithFormat:@"%@…\u2060%@",index1Str,index2Str];
    }
    return self;
}

- (NSDictionary *)getWebViewJSONDicWithPrefix:(NSString *)prefix{
    NSDictionary *jsonDic = nil;
    if ([self hasPrefix:prefix]) {
        NSString *jsonStr = [self substringFromIndex:prefix.length];
        
        jsonStr = [jsonStr stringByRemovingPercentEncoding];
        if (jsonStr) {
            jsonDic = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL];
            if (jsonDic && [jsonDic isKindOfClass:[NSDictionary class]]) {
                return jsonDic;
            }
        }
    }
    return jsonDic;
}

@end
