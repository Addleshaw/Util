//
//  NSString+Pinyin.m
//  base
//
//  Created by wangshuguan on 15/6/13.
//  Copyright (c) 2015年 wsg. All rights reserved.
//

#import "NSURL+Category.h"

#ifndef img_URL

#define img_URL @"http://"

#endif
@implementation NSURL(Category)

+(NSURL*)webUrl:(NSString*)str{
    if (![str hasPrefix:@"http"]) {
        return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",img_URL,str]];
    }
    return [NSURL URLWithString:str];
}
@end
