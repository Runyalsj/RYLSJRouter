//
//  GDKit_Router.h
//  GDKit_Router_Example
//
//  Created by 兔兔 on 2018/11/20.
//  Copyright © 2018 Runyalsj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// target-action 两个参数来确定target 和 action NSDictionary para
@interface GDKit_Router : NSObject

//这是单例
+ (instancetype)sharedInstance;

/** 打开链接 */
- (id)openUrl:(NSString *)urlStr;

// 返回值id
// 外部调用, 通过target和action来唯一确认一个类里面的方法
- (id)performTarget:(NSString *)targetName action:(NSString *)actionName param:(NSDictionary *)para;
@end

NS_ASSUME_NONNULL_END

#import <Foundation/Foundation.h>


