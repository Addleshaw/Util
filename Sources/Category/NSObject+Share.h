//
//  NSObject+Share.h
//  ChildrenSearch
//
//  Created by qingyun on 15/7/17.
//  Copyright (c) 2015年 qingyun.con. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShareSDK/ShareSDK.h>

@interface NSObject (Share)

+ (void)shareImages:(NSArray *)imageArray
               text:(NSString *)text
              title:(NSString *)title
                url:(NSString *)urlStr;

//单个
+ (void)shareType:(SSDKPlatformType)platformType
        shareDesc:(NSString *)shareDesc
              url:(NSString *)url
       shareTitle:(NSString *)shareTitle;

@end
