//
//  UIButton+block.m
//  TangXianManual
//
//  Created by apple on 15/9/17.
//  Copyright (c) 2015年 Han. All rights reserved.
//

#import "UIButton+block.h"
#import <objc/runtime.h>

static char overviewKey;
@implementation UIButton (block)


- (void)handleContentEvent:(UIControlEvents)event withBlock:(ActionBlock)action {
    objc_setAssociatedObject(self, &overviewKey, action, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(callActionBlock:) forControlEvents:event];
}


- (void)callActionBlock:(id)sender {
    ActionBlock block = (ActionBlock)objc_getAssociatedObject(self, &overviewKey);
    if (block) {
        block();
    }
}
@end
