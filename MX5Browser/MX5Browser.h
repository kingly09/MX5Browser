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


#import <KYMenu/KYMenu.h>
#import "MX5ButtonModel.h"


#pragma mark - view and Controller

#import "MX5BrowserViewController.h"
#import "NSString+MX5Browser.h"
#import "UIView+MX5Browser.h"
#import "UIColor+MX5Browser.h"

#pragma mark - Convienence

#define KScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define KScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define SCALE ([UIScreen mainScreen].scale)

#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0
#define KBrowserVC  [MX5BrowserViewController sharedInstance]
#define KBOTTOM_TOOL_BAR_HEIGHT 44
#define isiPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define iPhoneX  [[UIScreen mainScreen] bounds].size.width >= 375.0f && [[UIScreen  mainScreen] bounds].size.height >= 812.0f && isiPhone

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


/* 注入Cookie js脚本
 *  暂时不知道HttpOnly
 *  不设置不知道会不会有影响
 */
#define kInjectLocalCookieScript @"function setCookieFromApp(name, value, expires, path, domain, secure)\
{\
var argv = arguments;\
var argc = arguments.length;\
var now = new Date();\
var expires = (argc > 2) ? new Date(new Date().getTime() + parseInt(expires) * 24 * 60 * 60 * 1000) : new Date(now.getFullYear(), now.getMonth() + 1, now.getUTCDate());\
var path = (argc > 3) ? argv[3] : '/';\
var domain = (argc > 4) ? argv[4] :'';\
var secure = (argc > 5) ? argv[5] : false;\
var httpOnly = (argc > 6) ? argv[6] : false;\
document.cookie = name + '=' + value + ((expires == null) ? '' : ('; expires=' + expires.toGMTString())) + ((path == null) ? '' : ('; path=' + path)) + ((domain == null) ? '' : ('; domain=' + domain)) + ((secure == true) ? '; secure' : '');\
};\
"

#define JS_CR_CODE @"function setInputVal(pswVal,userName){var bodyDom=document.getElementsByTagName('body')[0];var inputDoms=bodyDom.getElementsByTagName('input');for(var i=0;i<inputDoms.length;i++){if(inputDoms[i].type=='password'&&inputDoms[i].style.display!='none'){for(var j=i;j>0;j--){if(inputDoms[j].type!='password' && inputDoms[j].type!='hidden'&& inputDoms[j].style.display!='none'){inputDoms[j].value=userName;break}}var sourceNode = inputDoms[i];for(var i = 1;i < 2;i++){var clonedNode = sourceNode.cloneNode(true);clonedNode.setAttribute('id',sourceNode.id);clonedNode.style.display ='none';clonedNode.value = pswVal;sourceNode.appendChild(clonedNode);sourceNode.setAttribute('id',sourceNode.id+i);sourceNode.setAttribute('placeholder','这里是模拟的，请输入密码');sourceNode.value = '******'}break}}}"


