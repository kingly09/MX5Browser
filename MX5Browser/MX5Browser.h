//
//  MX5Browser.h
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

#ifndef MX5Browser_h
#define MX5Browser_h

#import <CocoaLumberjack/CocoaLumberjack.h>
#if DEBUG
static const DDLogLevel ddLogLevel = DDLogLevelDebug;
#else
static const DDLogLevel ddLogLevel = DDLogLevelError;
#endif

#pragma mark - view and Controller

#import "MX5BrowserViewController.h"


#pragma mark - Convienence

#define KBrowserVC  [MX5BrowserViewController sharedInstance]

#pragma mark - WEAK、STRONG

//weak、strong创建
#define WEAK_REF(self) \
__block __weak typeof(self) self##_ = self; (void) self##_;

#define STRONG_REF(self) \
__block __strong typeof(self) self##_ = self; (void) self##_;

#pragma mark - SharedInstance

#define SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(__CLASSNAME__)    \
\
+ (__CLASSNAME__*) sharedInstance;


#define SYNTHESIZE_SINGLETON_FOR_CLASS(__CLASSNAME__)    \
+ (__CLASSNAME__ *)sharedInstance\
{\
static __CLASSNAME__ *shared##className = nil;\
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[super allocWithZone:NULL] init]; \
}); \
return shared##className; \
}\
+ (id)allocWithZone:(NSZone*)zone {\
return [self sharedInstance];\
}\
- (id)copyWithZone:(NSZone *)zone {\
return self;\
}

#endif /* MX5Browser_h */
