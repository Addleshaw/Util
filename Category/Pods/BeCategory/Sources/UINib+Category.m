//
//  UINib+Category.m
//  Yun
//
//  Created by Bernie on 2017/8/7.
//  Copyright © 2017年 lq. All rights reserved.
//

#import "UINib+Category.h"

@implementation UINib(Category)

+(UINib *)xibName:(NSString *)name{
    return [UINib nibWithNibName:name bundle:nil];
}

@end
