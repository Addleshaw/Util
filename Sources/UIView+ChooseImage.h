//
//  UIView+ChooseImage.h
//  Yun
//
//  Created by my on 2017/3/6.
//  Copyright © 2017年 lq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ChooseImage)

+ (void)chooseImageFromeVC:(UIViewController *)vc result:(void(^)(BOOL,UIImage *,NSDictionary *))result;
+ (void)chooseImageFromeVC:(UIViewController *)vc max:(int)count pickerAction:(void(^)(NSArray<UIImage *>*,NSArray*,BOOL))pickerAction;
@end
