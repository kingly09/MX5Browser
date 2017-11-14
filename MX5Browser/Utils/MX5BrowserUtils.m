//
//  MX5BrowserUtils.m
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

#import "MX5BrowserUtils.h"
#import "NSString+MX5Browser.h"

@implementation MX5BrowserUtils

+ (BOOL)canAppHandleURL:(NSURL *)url{
    if (([url.scheme isEqualToString:@"http"] || [url.scheme isEqualToString:@"https"]) && [url.host isEqualToString:@"itunes.apple.com"]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isURL:(NSString *)urlString{
    if(urlString && [urlString length] > 0)
    {
        if([urlString hasPrefix:@"http://"])
        {
            NSString* temp = [urlString stringByReplacingOccurrencesOfString:@"http://" withString:@""];
            NSRange position = [temp rangeOfString:@"/"];
            if(NSNotFound == position.location)
            {
                return [temp isValidURL];
            }
            else
            {
                temp = [temp substringToIndex:position.location];
                return [temp isValidURL];
            }
        }
        else if([urlString hasPrefix:@"https://"])
        {
            NSString* temp = [urlString stringByReplacingOccurrencesOfString:@"https://" withString:@""];
            NSRange position = [temp rangeOfString:@"/"];
            if(NSNotFound == position.location)
            {
                return [temp isValidURL];
            }
            else
            {
                temp = [temp substringToIndex:position.location];
                return [temp isValidURL];
            }
        }
        else
        {
            NSURL* url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            if(!url)
                return NO;
            
            NSRange position = [urlString rangeOfString:@"/"];
            if(NSNotFound == position.location)
            {
                if([urlString rangeOfString:@" "].location != NSNotFound)
                    return NO;
                
                return [urlString isValidURL];
            }
            else
            {
                NSString* temp = [urlString substringToIndex:position.location];
                if([temp rangeOfString:@" "].location != NSNotFound)
                    return NO;
                
                return [temp isValidURL];
            }
        }
    }
    
    return NO;
}

@end
