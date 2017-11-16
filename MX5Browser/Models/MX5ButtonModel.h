//
//  MX5ButtonModel.h
//  MX5BrowserOC
//
//  Created by kingly on 2017/11/15.
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
#import "MX5SubButtonModel.h"


@protocol MX5ButtonModel <NSObject>

@end
/**
 一级菜单的模型对象
 */
@interface MX5ButtonModel : NSObject

@property (nonatomic,copy) NSString  *type;         // 顶级菜单的button的类型
@property (nonatomic,copy) NSString  *name;         // 菜单名称
@property (nonatomic,copy) NSString  *key;          // 菜单对应的key值
@property (nonatomic,copy) NSArray   *sub_button;   // 是有子菜单

@end
