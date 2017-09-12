//
//  UIViewController+Category.h
//  return
//
//  Created by Bernie on 2017/8/3.
//  Copyright © 2017年 Bernie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIViewController(Category)



+ (void)swizzleInstanceSelector:(SEL)origSelector withNewSelector:(SEL)newSelector;//替换对象方法
+ (void)swizzleClassSelector:(SEL)origSelector withNewSelector:(SEL)newSelector;//替换类方法

@end
