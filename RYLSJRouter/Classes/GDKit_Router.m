//
//  GDKit_Router.m
//  GDKit_Router_Example
//
//  Created by 兔兔 on 2018/11/20.
//  Copyright © 2018 Runyalsj. All rights reserved.
//

#import "GDKit_Router.h"

@implementation GDKit_Router

+ (instancetype)sharedInstance{
    static GDKit_Router *mediator;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mediator = [[GDKit_Router alloc] init];
    });
    return mediator;
}


// http://Index/home?useName=zhangshan&password=123
- (id)openUrl:(NSString *)urlStr {
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    // 查询
    NSString *urlString = [url query];
    // 切割字符串
    for (NSString *param in [urlString componentsSeparatedByString:@"&"]) {
        NSArray *elts = [param componentsSeparatedByString:@"="];
        if ([elts count] < 2) continue;
        id fristEle = [elts firstObject];
        id lastEle = [elts lastObject];
        
        if (fristEle && lastEle) {
            [params setObject:lastEle forKey:fristEle];
        }
    }
    NSString *actionName = [url.path stringByReplacingOccurrencesOfString:@"/" withString:@""];
    if ([actionName hasPrefix:@"native"]) {
        return @(NO);
    }
    id result = [self performTarget:url.host action:actionName param:params];
    return result;
}

- (id)performTarget:(NSString *)targetName action:(NSString *)actionName param:(NSDictionary *)para {
    // 这个目标的类名字符串
    NSString *targetClassString = [NSString stringWithFormat:@"GDKit_%@",targetName];
    NSString *actionMethondString = [NSString stringWithFormat:@"action_%@:",actionName];
    Class targetClass = NSClassFromString(targetClassString);
    NSObject *target = [[targetClass alloc] init];
    SEL action = NSSelectorFromString(actionMethondString);
    
    // 判断
    if ([target respondsToSelector:action]) {
        return [self safePerformAction:action target:target param:para];
    } else {
        SEL action = NSSelectorFromString(@"notFound:");
        if ([target respondsToSelector:action]) {
            return [self safePerformAction:action target:target param:para];
        } else {
            return nil;
        }
    }
}


// 1.通过对象调用指定的方法
// 2.传参
- (id)safePerformAction:(SEL)action target:(NSObject *)target param:(NSDictionary *)para {
    NSMethodSignature *methodSig = [target methodSignatureForSelector:action];
    if (methodSig == nil) return nil;
    // 获取这个方法返回值的地址
    const char *retType = [methodSig methodReturnType];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
    [invocation setTarget:target];
    [invocation setSelector:action];
    // id 是可以返回任意对象 所以 我们单独处理基本变量. NSInteger Bool Void...
    if (strcmp(retType, "@") == 0) {
        // 为什么传2? 前面0和1这两个位置已经被target和action给占用了.
        [invocation setArgument:&para atIndex:2];
    }
    
    if (strcmp(retType, @encode(void)) == 0) {
        // 为什么传2? 前面0和1这两个位置已经被target和action给占用了.
        [invocation setArgument:&para atIndex:2];
    }
    
    if (strcmp(retType, @encode(NSInteger)) == 0) {
        // 为什么传2? 前面0和1这两个位置已经被target和action给占用了.
        [invocation setArgument:&para atIndex:2];
    }
    
    if (strcmp(retType, @encode(NSUInteger)) == 0) {
        // 为什么传2? 前面0和1这两个位置已经被target和action给占用了.
        [invocation setArgument:&para atIndex:2];
    }
    
    if (strcmp(retType, @encode(BOOL)) == 0) {
        // 为什么传2? 前面0和1这两个位置已经被target和action给占用了.
        [invocation setArgument:&para atIndex:2];
    }
    
    if (strcmp(retType, @encode(CGFloat)) == 0) {
        // 为什么传2? 前面0和1这两个位置已经被target和action给占用了.
        [invocation setArgument:&para atIndex:2];
    }
    [invocation invoke];
    
    id result = 0;
    [invocation getReturnValue:&result];
    return result;
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    return [target performSelector:action withObject:target withObject:para];
#pragma clang diagnostic pop
}
@end
