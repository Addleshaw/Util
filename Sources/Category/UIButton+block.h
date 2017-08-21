//
//  UIButton+block.h
//  TangXianManual
//
//  Created by apple on 15/9/17.
//  Copyright (c) 2015年 Han. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ActionBlock)();
@interface UIButton (block)

- (void)handleContentEvent:(UIControlEvents)event withBlock:(ActionBlock)action;


@end
