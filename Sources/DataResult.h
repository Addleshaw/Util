//
//  DataResult
//  Contact
//
//  Created by Bernie on 16/7/12.
//  Copyright © 2016年 Bernie. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface DataResult : NSObject
@property(strong,nonatomic)NSString *errorMsg;
@property(assign,nonatomic)BOOL status;
@property(assign,nonatomic)int Ecode;
@property(strong,nonatomic)NSDictionary* dataDic;
+(DataResult *)getResultFromDic:(NSDictionary *)dic;

@end
