//
//  DataResult
//  Contact
//
//  Created by Bernie on 16/7/12.
//  Copyright © 2016年 Bernie. All rights reserved.
//
#import "DataResult.h"
#define API_STATUS @"response_code"
#define API_MSG @"show_err"

@implementation DataResult
@synthesize errorMsg=_errorMsg;
+(DataResult *)getResultFromDic:(NSDictionary *)dic{
    DataResult *result = [[DataResult alloc]init];
    result.dataDic = @{};
    result.status = NO;
    result.errorMsg = @"";
    result.Ecode = 0;
    if (!dic || ![dic objectForKey:API_STATUS]) {
        result.status = NO;
        result.errorMsg = @"网络错误";
        return result;
    }

    if (dic && [[dic stringFromKey:API_STATUS] isEqualToString:@"1"]) {
        result.errorMsg = [dic objectForKey:API_MSG];
        result.status = YES;
        result.Ecode = [[dic objectForKey:API_STATUS] intValue];
        result.dataDic = dic;
    }else if(dic && [[dic stringFromKey:API_STATUS] isEqualToString:@"0"]){
        result.errorMsg = [dic objectForKey:API_MSG];
    }
    return result;
}
@end
