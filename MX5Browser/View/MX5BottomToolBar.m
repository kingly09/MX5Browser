//
//  MX5BottomToolBar.m
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

#import "MX5BottomToolBar.h"
#import "MX5Browser.h"
#define KMenuButtonTag 10000

@interface MX5BottomToolBar() {
    
    NSMutableArray *menuArray;
    OptionalConfiguration  optionals;
    MX5ButtonModel *currButtonModel;  //当前选中的父菜单
    UIView *underscoreView;           //底线
    
}
@property (nonatomic, strong) UIView *bottomToolBar;  //底部视图
@property (nonatomic, strong) UIButton *localBtn;     //不变的button
@property (nonatomic, strong) UIView *menuView;       //菜单视图
@property (nonatomic, strong) UIView *parentview;     //菜单所处于的父视图
@property (nonatomic, strong) NSArray *menuViewArr;   //菜单数组



@end

@implementation MX5BottomToolBar


-(void)dealloc {
    
    DDLogDebug(@"MX5BottomToolBar dealloc");
    
    [_bottomToolBar removeFromSuperview];
    _bottomToolBar = nil;
    
    [_localBtn removeFromSuperview];
    _localBtn = nil;
    
    [_menuView removeFromSuperview];
    _menuView = nil;
    
    [_parentview removeFromSuperview];
    _parentview = nil;
    
    
    [underscoreView removeFromSuperview];
    underscoreView = nil;
    
    _menuViewArr = nil;
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initializeView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame withParentview:(UIView *)parentview {
    
    if (self = [super initWithFrame:frame]) {
        [self initializeView];
        self.parentview = parentview;
    }
    return self;
}

- (void)initializeView {

    self.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor whiteColor];
    
    _bottomToolBar = [[UIView alloc] init];
    _bottomToolBar.frame = self.bounds;
    _bottomToolBar.userInteractionEnabled = YES;
    [_bottomToolBar setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [self addSubview:_bottomToolBar];

    [self addBottomToolBarSubview];
    
    Color textColor;
    textColor.R = 0;
    textColor.G = 0;
    textColor.B = 0;
    
    Color menuBackgroundColor;
    menuBackgroundColor.R = 1;
    menuBackgroundColor.G = 1;
    menuBackgroundColor.B = 1;
    
   
    optionals.arrowSize = 0;                    //指示箭头大小
    optionals.marginXSpacing = 7;               //MenuItem左右边距
    optionals.marginYSpacing = 9;               //MenuItem上下边距
    optionals.intervalSpacing = 25;             //MenuItemImage与MenuItemTitle的间距
    optionals.menuCornerRadius = 0;              //菜单圆角半径
    optionals.maskToBackground = NO ;           //是否添加覆盖在原View上的半透明遮罩
    optionals.shadowOfMenu     = YES ;          //是否添加菜单阴影
    optionals.hasSeperatorLine = YES ;          //是否设置分割线
    optionals.seperatorLineHasInsets = NO ;     //是否在分割线两侧留下Insets
    optionals.textColor = textColor;            //menuItem字体颜色
    optionals.shadowOfMenuOutside = YES;
    optionals.notContainsSubview = YES;
    
    optionals.menuBackgroundColor = menuBackgroundColor; //菜单的底色
    

}

/**
 添加工具视图的子视图
 */
-(void)addBottomToolBarSubview{
    
    //左边不变的按钮
    _localBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    [_localBtn setExclusiveTouch:YES];
    [_localBtn adjustsImageWhenHighlighted];
    [_localBtn adjustsImageWhenDisabled];
    [_localBtn setBackgroundColor:[UIColor clearColor]];
    [_localBtn addTarget:self action:@selector(clickLocalBtn:) forControlEvents:UIControlEventTouchUpInside];
    _localBtn.frame = CGRectMake(0,0, KBOTTOM_TOOL_BAR_HEIGHT, KBOTTOM_TOOL_BAR_HEIGHT);
    [_localBtn setImage:[UIImage imageNamed:@"m_ic_apply"] forState:UIControlStateNormal];
    [_bottomToolBar addSubview:_localBtn];
    
    //自定义菜单
    _menuView =  [[UIView alloc] init];
    _menuView.userInteractionEnabled = YES;
    _menuView.size = CGSizeMake(self.width - KBOTTOM_TOOL_BAR_HEIGHT , KBOTTOM_TOOL_BAR_HEIGHT);
    _menuView.x    = KBOTTOM_TOOL_BAR_HEIGHT;
    [_bottomToolBar addSubview:_menuView];
    

    //添加一根竖线
    UIView *lineView = [[UIView alloc] init];
    lineView.size = CGSizeMake(1/SCALE , KBOTTOM_TOOL_BAR_HEIGHT);
    lineView.x    = KBOTTOM_TOOL_BAR_HEIGHT;
    lineView.backgroundColor = [UIColor colorWithHexStr:@"#c3c3c3"];
    [_bottomToolBar addSubview:lineView];
    
    //顶部的横线
    UIView *toplineView = [[UIView alloc] init];
    toplineView.size = CGSizeMake(self.width , 1/SCALE );
    toplineView.backgroundColor = [UIColor colorWithHexStr:@"#c3c3c3"];
    [_bottomToolBar addSubview:toplineView];
    
    //底线
    underscoreView = [[UIView alloc] init];
    underscoreView.size = CGSizeMake(self.width , 1/SCALE );
    underscoreView.backgroundColor = [UIColor colorWithHexStr:@"#c3c3c3"];
    underscoreView.y = _bottomToolBar.height - 1/SCALE;
   [_bottomToolBar addSubview:underscoreView];
    
    
}

/**
 显示自定义的菜单
 */
-(void)showMenuView {
    
    if (_menuViewArr.count > 0) {
        float buttonWidth = _menuView.width/_menuViewArr.count;
        
        for (int i = 0; i < _menuViewArr.count; i++) {
            
            MX5ButtonModel *buttonModel = [_menuViewArr objectAtIndex:i];
            
            UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            itemBtn.size = CGSizeMake(buttonWidth, KBOTTOM_TOOL_BAR_HEIGHT);
            itemBtn.x    =  buttonWidth * i;
            [itemBtn setExclusiveTouch:YES];
            [itemBtn setBackgroundColor:[UIColor clearColor]];
            itemBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            [itemBtn adjustsImageWhenHighlighted];
            itemBtn.tag = KMenuButtonTag + i;
            [itemBtn adjustsImageWhenDisabled];
            itemBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            [itemBtn setTitle:buttonModel.name forState:UIControlStateNormal];
            [itemBtn setTitleColor:[UIColor colorWithHexStr:@"#101010"] forState:UIControlStateNormal];
            [itemBtn addTarget:self action:@selector(clickItemBtn:) forControlEvents:UIControlEventTouchUpInside];
            [_menuView addSubview:itemBtn];
            
            //如果有子菜单的显示小三角形
            if (buttonModel.sub_button.count > 0 ) {
                
                UIImageView *image = [[UIImageView alloc] init];
                image.image = [UIImage imageNamed:@"m_ic_sjx"];
                image.size = CGSizeMake(8, 8);
                image.x    = itemBtn.width - 13;
                image.y    = itemBtn.height - 13;
                [itemBtn addSubview:image];
            }
            
            if ((i + 1) != _menuViewArr.count) {
                UIView *lineView = [[UIView alloc] init];
                lineView.size = CGSizeMake(1/SCALE , KBOTTOM_TOOL_BAR_HEIGHT);
                lineView.x    = buttonWidth * (i + 1);
                lineView.backgroundColor = [UIColor colorWithHexStr:@"#c3c3c3"];
                [_menuView addSubview:lineView];
            }
        }
    }
}

/**
 点击小菜单消失视图
 */
-(void) dismissMenu {
    [KYMenu dismissMenu];
    for (id obj in _menuView.subviews)  {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *theButton = (UIButton*)obj;
            theButton.selected = NO;
        }
    }
}

#pragma mark - 对外方法

- (void)reloadMenuView:(NSArray *)menuViewArr{
    
    _menuViewArr = menuViewArr;

    [self showMenuView];
    
}

/**
 显示子菜单

 @param bModel 菜单对象
 @param menuFrame 子菜单显示的位置
 */
-(void)showSupMemuView:(MX5ButtonModel *)bModel  withMenuFrame:(CGRect )menuFrame{
    
    menuArray = [NSMutableArray array];
    for (MX5SubButtonModel *subButtonModel in bModel.sub_button) {
        [menuArray addObject:[KYMenuItem menuItem:subButtonModel.name image:nil target:self action:@selector(onMenuItemAction:)]];
    }
    [KYMenu setTitleFont:[UIFont systemFontOfSize:14]];
    [KYMenu showMenuInView:self.parentview
                  fromRect:menuFrame
                 menuItems:menuArray withOptions:optionals];
}

#pragma mark - 点击事件
/**
 点击左边不变的按钮
 */
- (void)clickLocalBtn:(UIButton *)sender {
    
    [self dismissMenu];
  
     if(_delegate && [_delegate respondsToSelector:@selector(onClickBottomToolBarWithLocalBtn)]){
            [self.delegate onClickBottomToolBarWithLocalBtn];
        }
}

/**
 点击一级菜单
 */
- (void)clickItemBtn:(UIButton *)sender {
    
    NSInteger tag = sender.tag - KMenuButtonTag;
    
     sender.selected =!sender.selected;
    
     MX5ButtonModel *buttonModel = [_menuViewArr objectAtIndex:tag];
    
    for (id obj in _menuView.subviews)  {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *theButton = (UIButton*)obj;
            if (theButton.tag ==  sender.tag) {

            }else{
                theButton.selected = NO;
            }
        }
    }

    if (sender.selected == YES) {
        
       
        //如果子菜单的显示子菜单
        if (buttonModel.sub_button.count > 0 ) {
             currButtonModel = buttonModel;
            float menuButtonX = KBOTTOM_TOOL_BAR_HEIGHT + sender.width * tag;
            CGRect menuFrame = CGRectMake(menuButtonX, KScreenHeight - KBOTTOM_TOOL_BAR_HEIGHT - 5, sender.width, sender.height);
            if ( iPhoneX) {
                menuFrame = CGRectMake(menuButtonX, KScreenHeight - KBOTTOM_TOOL_BAR_HEIGHT - 25, sender.width, sender.height);
            }
            [self showSupMemuView:buttonModel withMenuFrame:menuFrame];
        }else{
            //关闭其他的菜单
            [self dismissMenu];
            if(_delegate && [_delegate respondsToSelector:@selector(onClickBottomToolBarWithMemubutton:)]){
                [self.delegate onClickBottomToolBarWithMemubutton:buttonModel];
            }
        }
    }else{
        
        [self dismissMenu];
        if(_delegate && [_delegate respondsToSelector:@selector(onClickBottomToolBarWithMemubutton:)]){
            [self.delegate onClickBottomToolBarWithMemubutton:buttonModel];
        }
    }
}


/**
 点击二级菜单

 */
- (void)onMenuItemAction:(id)sender{
    
    KYMenuItem *menuItem = sender;

    [self dismissMenu];

    if (currButtonModel.sub_button.count > 0) {
        
        for (MX5SubButtonModel *subButtonModel  in currButtonModel.sub_button) {
            
            if ([subButtonModel.name isEqualToString:menuItem.title]) {
                
                if(_delegate && [_delegate respondsToSelector:@selector(onClickBottomToolBarWithSubMemubutton:)]){
                    [self.delegate onClickBottomToolBarWithSubMemubutton:subButtonModel];
                }
                break;
            }
        }
    }

}



@end
