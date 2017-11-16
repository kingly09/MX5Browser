//
//  MX5BottomToolBar.h
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

@class MX5ButtonModel,MX5SubButtonModel;
@protocol MX5BottomToolBarDelegate <NSObject>

/**
 点击自定义的一级菜单

 @param buttonModel 一级菜单对象
 */
-(void)onClickBottomToolBarWithMemubutton:(MX5ButtonModel *)buttonModel;
/**
 点击自定义的二级菜单
 @param buttonModel 二级菜单对象
 */
-(void)onClickBottomToolBarWithSubMemubutton:(MX5SubButtonModel *)buttonModel;

@end

/**
 浏览器底部菜单栏
 */
@interface MX5BottomToolBar : UIView

- (instancetype)initWithFrame:(CGRect)frame withParentview:(UIView *)parentview;

@property (nonatomic, weak) id<MX5BottomToolBarDelegate> delegate;
/**
 加载自定义的菜单数组

 @param menuViewArr 自定义的菜单数组
 */
- (void)reloadMenuView:(NSArray *)menuViewArr;

NS_ASSUME_NONNULL_END

@end
