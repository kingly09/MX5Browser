//
//  MX5BrowserURLCache.h
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

#import <Foundation/Foundation.h>
#import "MX5Browser.h"

NS_ASSUME_NONNULL_BEGIN

@interface MX5BrowserUtil : NSObject
/**
 sha1 加密算法
 @param str 需要加密的字符串
 @return 返回加密字符串
 */
+ (NSString *)sha1:(NSString *)str;

/**
 MD5Hash加密算法
 
 @param str 需要加密的字符串
 @return 加密字符串
 */
+ (NSString *)md5Hash:(NSString *)str;

@end

/**
 浏览器URLCache
 */
@interface MX5BrowserURLCache : NSURLCache

@property(nonatomic, assign) NSInteger cacheTime;  //缓存时间
@property(nonatomic, retain) NSString *diskPath;   //磁盘地址
@property(nonatomic, retain) NSMutableDictionary *responseDictionary;


/**
 设置网页缓存

 @param memoryCapacity 分配的内存空间大小 例如 20m （20 * 1024 * 1024）
 @param diskCapacity  分配磁盘空间大小 例如 200m （ 200 * 1024 * 1024）
 @param path 设置磁盘路径地址，如果没有设置为NSCachesDirectory路径
 @param cacheTime 缓存网页的时间
 @return 返回带有缓存的网页
 */
- (id)initWithMemoryCapacity:(NSUInteger)memoryCapacity diskCapacity:(NSUInteger)diskCapacity diskPath:(NSString *)path cacheTime:(NSInteger)cacheTime;

/**
 清理缓存的方法，这个方法会清除缓存类型为HTML类型的文件
 */
- (void)clearHtmlCache;


SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER (MX5BrowserURLCache)


@end


NS_ASSUME_NONNULL_END

