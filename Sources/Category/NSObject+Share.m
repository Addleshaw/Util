//
//  NSObject+Share.m
//  ChildrenSearch
//
//  Created by qingyun on 15/7/17.
//  Copyright (c) 2015年 qingyun.con. All rights reserved.
//

#import "NSObject+Share.h"
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
#import <ShareSDKUI/SSUIEditorViewStyle.h>

@implementation NSObject (Share)


+ (void)shareImages:(NSArray *)imageArray
               text:(NSString *)text
              title:(NSString *)title
                url:(NSString *)urlStr {
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:text
                                         images:imageArray
                                            url:[NSURL URLWithString:urlStr]
                                          title:title
                                           type:SSDKContentTypeAuto];
        
        //有的平台要客户端分享需要加此方法，例如微博
        [shareParams SSDKEnableUseClientShare];
        
        
        // 设置分享菜单栏样式（非必要）
        // 设置分享菜单的背景颜色
        [SSUIShareActionSheetStyle setActionSheetBackgroundColor:[UIColor colorWithWhite:0 alpha:.3]];
        [SSUIEditorViewStyle setStatusBarStyle:UIStatusBarStyleLightContent];
        [SSUIShareActionSheetStyle setShareActionSheetStyle:ShareActionSheetStyleSimple];
        
        
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];}
}



#pragma mark - 自定义分享
+ (void)shareType:(SSDKPlatformType)platformType
        shareDesc:(NSString *)shareDesc
              url:(NSString *)url
       shareTitle:(NSString *)shareTitle {
    //1、创建分享参数（必要）
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:shareDesc
                                     images:[UIImage imageNamed:@"shopIcon.png"]
                                        url:[NSURL URLWithString:url]
                                      title:shareTitle
                                       type:SSDKContentTypeAuto];
    [ShareSDK share:platformType parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
        switch (state) {
            case SSDKResponseStateSuccess:
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                    message:nil
                                                                   delegate:nil
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                [alertView show];
                break;
            }
            case SSDKResponseStateFail:
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                message:[NSString stringWithFormat:@"%@",error.userInfo[@"error_message"]]
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
                [alert show];
                break;
            }
            default:
                break;
        }
    }];
}


@end
