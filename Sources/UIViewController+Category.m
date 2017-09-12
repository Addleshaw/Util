//
//  UIViewController+Category.m
//  return
//
//  Created by Bernie on 2017/8/3.
//  Copyright © 2017年 Bernie. All rights reserved.
//

#import "UIViewController+Category.h"
#import <objc/runtime.h>

@implementation UIViewController(Category)


//替换对象方法
+ (void)swizzleInstanceSelector:(SEL)origSelector withNewSelector:(SEL)newSelector{
    Method method1 = class_getInstanceMethod([self class], origSelector);
    Method method2 = class_getInstanceMethod([self class], newSelector);
    method_exchangeImplementations(method1, method2);
}
//替换类方法
+ (void)swizzleClassSelector:(SEL)origSelector withNewSelector:(SEL)newSelector{
    Method method1 = class_getClassMethod([self class], origSelector);
    Method method2 = class_getClassMethod([self class], newSelector);
    method_exchangeImplementations(method1, method2);
}


@end
