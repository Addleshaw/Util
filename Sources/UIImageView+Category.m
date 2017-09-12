//
//  UIImageView+Category.m
//  return
//
//  Created by Bernie on 2017/7/3.
//  Copyright © 2017年 Bernie. All rights reserved.
//

#import "UIImageView+Category.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (Category)

-(void)imageWithSrc:(NSString*)src{
    [self imageWithSrc:src complate:nil];
}
-(void)imageWithSrc:(NSString*)src complate:(void(^)())complate{
//    [self setContentMode:UIViewContentModeScaleAspectFill];
    
    [self sd_setImageWithURL:[NSURL webUrl:src] placeholderImage:[UIImage imageNamed:@"goodsimgDefault"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (error==nil) {
//            [self setContentMode:UIViewContentModeScaleAspectFill];
        }
        if (complate!=nil) {
            complate();
        }
    }];
}

@end
