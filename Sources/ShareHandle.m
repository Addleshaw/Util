//
//  UIImageView+Category.h
//  return
//
//  Created by Bernie on 2017/7/3.
//  Copyright © 2017年 Bernie. All rights reserved.
//

#import "ShareHandle.h"


@implementation ShareHandle
+(ShareHandle *)share{
    static ShareHandle *sh;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sh = [[ShareHandle alloc]init];
    });
    return sh;

}
- (id)init
{
    self = [super init];
    if (self) {
        _locationPoint = @{@"city":@"全国",
                           @"code":@"",
                           @"loca":[[CLLocation alloc]initWithLatitude:0 longitude:0],
                           @"adres":@""};
    }
    return self;
}
-(NSString *)city{
    return [_locationPoint stringFromKey:@"city"];
}
-(NSString *)citycode{
    return [_locationPoint stringFromKey:@"code"];
}
-(CLLocation *)location{
    if (_location==nil) {
        return [_locationPoint objectForKey:@"loca"];
    }
    return _location;
}
-(NSString *)address{
    return [_locationPoint stringFromKey:@"adres"];
}




@end
