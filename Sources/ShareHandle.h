//
//  UIImageView+Category.h
//  return
//
//  Created by Bernie on 2017/7/3.
//  Copyright © 2017年 Bernie. All rights reserved.
//




@interface ShareHandle : NSObject

+(ShareHandle *)share;



@property(nonatomic,strong)NSDictionary*locationPoint;

@property(nonatomic,strong)CLLocation*location;
@property(nonatomic,readonly)NSString*city;
@property(nonatomic,readonly)NSString*citycode;
@property(nonatomic,readonly)NSString*address;

@end
