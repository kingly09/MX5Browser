//
//  ViewController.m
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

#import "ViewController.h"
#import "MX5Browser.h"
#import  <YYKit/YYKit.h>

@interface ViewController ()<UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"测试MX5";
  
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 点击测试MX5Browser
 */
- (IBAction)onClickTestBrowser:(id)sender {
    
    
    NSArray *menuLists = [NSArray modelArrayWithClass:[MX5ButtonModel class] json:[NSData dataNamed:[NSString stringWithFormat:@"menuList.geojson"]]];
    
    MX5BrowserViewController *browserViewController = [[MX5BrowserViewController alloc] init];
    [browserViewController loadWebURLSring:@"http://www.baidu.com"];
    [browserViewController loadMenuView:menuLists];
    [self.navigationController pushViewController:browserViewController animated:YES];
    
}

- (IBAction)onClickLocalHtml:(id)sender {
    
    
    NSArray *menuLists = [NSArray modelArrayWithClass:[MX5ButtonModel class] json:[NSData dataNamed:[NSString stringWithFormat:@"menuList.geojson"]]];
    
    MX5BrowserViewController *browserViewController = [[MX5BrowserViewController alloc] init];
    browserViewController.menuList = menuLists;
    //获取JS所在的路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"];
    [browserViewController loadLocalHTMLStringWithHtmlPath:path];
    
    [self.navigationController pushViewController:browserViewController animated:YES];
    
    
}

- (IBAction)onClickHTMLString:(id)sender {
    
    NSArray *menuLists = [NSArray modelArrayWithClass:[MX5ButtonModel class] json:[NSData dataNamed:[NSString stringWithFormat:@"menuList.geojson"]]];
    
    MX5BrowserViewController *browserViewController = [[MX5BrowserViewController alloc] init];
    browserViewController.menuList = menuLists;
    //获取JS所在的路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"text"];
    
    NSString *htmlString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    [browserViewController loadHTMLString:htmlString];
    
    [self.navigationController pushViewController:browserViewController animated:YES];
    
    
}


#pragma mark - UISearchBarDelegate 点击search跳到搜索结果页
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {

    NSArray *menuLists = [NSArray modelArrayWithClass:[MX5ButtonModel class] json:[NSData dataNamed:[NSString stringWithFormat:@"menuList.geojson"]]];
    
    MX5BrowserViewController *browserViewController = [[MX5BrowserViewController alloc] init];
    browserViewController.menuList = menuLists;
    [browserViewController loadWebURLSring:searchBar.text];
    
    [self.navigationController pushViewController:browserViewController animated:YES];
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
}

@end
