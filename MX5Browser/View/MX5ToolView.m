//
//  MX5ToolView.m
//  MX5BrowserOC
//
//  Created by kingly on 2017/11/17.
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

#import "MX5ToolView.h"
#import "MX5Browser.h"
#import "UIColor+MX5Browser.h"

@interface MX5ToolView()
{
    
    UIWindow *currWindow;
    UIView *allSuperView;
    
    UIView *toolView;
    UIView *buttonView;
    UIButton *closeButton;  //关闭按钮
    
    //放大
    UIView *enlargeView;
    UIButton *enlargeBtn;
    UILabel *enlargelabel;
    
    //缩小
    UIView *narrowView;
    UIButton *narrowBtn;
    UILabel *narrowlabel;
    
    //夜间模式
    UIView *nightView;
    UIButton *nightBtn;
    UILabel *nightlabel;
    
    //夜间模式
    UIView *collectionView;
    UIButton *collectionBtn;
    UILabel *collectionlabel;
    
}

@end

@implementation MX5ToolView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self customToolView];
    }
    return self;
}

-(void)dealloc {
    
    DDLogDebug(@"MX5ToolView dealloc");
    
}

- (void)customToolView
{
    currWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth,KScreenHeight)];
    currWindow.windowLevel = UIWindowLevelAlert;
    currWindow.backgroundColor = [UIColor colorWithHex:0x000000 alpha:0.2];
    currWindow.hidden = NO;
    //点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickExit)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [currWindow addGestureRecognizer:tap];
    
    allSuperView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    allSuperView.transform = CGAffineTransformMakeRotation(0);
    allSuperView.backgroundColor = [UIColor colorWithHex:0x000000 alpha:0.2];
    [currWindow addSubview:allSuperView];
    
    //添加工具
    toolView = [[UIView alloc] init];
    toolView.size = CGSizeMake(KScreenWidth, 152);
    toolView.y    = KScreenHeight - 152;
    toolView.backgroundColor = [UIColor colorWithHexStr:@"#f2f2f2"];
    [allSuperView addSubview:toolView];
    
    //btn视图
    buttonView = [[UIView alloc] init];
    buttonView.backgroundColor = [UIColor whiteColor];
    buttonView.size = CGSizeMake(KScreenWidth, 104);
    [toolView addSubview:buttonView];
    
    //设置btn视图
    [self setupButtonView];
    
    //关闭按钮
    closeButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setExclusiveTouch:YES];
    [closeButton adjustsImageWhenHighlighted];
    [closeButton adjustsImageWhenDisabled];
    [closeButton setBackgroundColor:[UIColor clearColor]];
    [closeButton addTarget:self action:@selector(clickExit) forControlEvents:UIControlEventTouchUpInside];
    closeButton.size = CGSizeMake(44, 48);
    closeButton.y    = 104;
    closeButton.x    = (KScreenWidth - 44)/2;
    [closeButton setImage:[UIImage imageNamed:@"m_ic_jt"] forState:UIControlStateNormal];
    [toolView addSubview:closeButton];
    

}

/**
 设置btn视图
 */
-(void)setupButtonView {
    
    //放大
    enlargeView = [[UIView alloc] init];
    enlargeView.size =  CGSizeMake(KScreenWidth/4, 104);
    
    enlargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [enlargeBtn setExclusiveTouch:YES];
    [enlargeBtn adjustsImageWhenHighlighted];
    [enlargeBtn adjustsImageWhenDisabled];
    [enlargeBtn setBackgroundColor:[UIColor clearColor]];
    [enlargeBtn addTarget:self action:@selector(clickExit) forControlEvents:UIControlEventTouchUpInside];
    enlargeBtn.size = CGSizeMake(40, 40);
    enlargeBtn.x    =  (KScreenWidth/4 - 40)/2;
    enlargeBtn.y    = 20;
    [enlargeBtn setImage:[UIImage imageNamed:@"m_ic_fd_word"] forState:UIControlStateNormal];
    [enlargeView addSubview:enlargeBtn];
    
    enlargelabel = [[UILabel alloc] init];
    enlargelabel.size = CGSizeMake(enlargeView.width, 20);
    enlargelabel.y    =  (104 - (enlargeBtn.y + enlargeBtn.height) - 20)/2  + enlargeBtn.y + enlargeBtn.height;
    enlargelabel.text = @"放大字体";
    enlargelabel.font = [UIFont systemFontOfSize:14];
    enlargelabel.textAlignment = NSTextAlignmentCenter;
    [buttonView addSubview:enlargeView];
    
    //缩小
    narrowView = [[UIView alloc] init];
    narrowView.size =  CGSizeMake(KScreenWidth/4, 104);
    [buttonView addSubview:narrowView];
    
    
}

//退出分享
-(void)clickExit {
    
    currWindow.hidden = YES;
    currWindow = nil;
    self.hidden = YES;
}

@end
