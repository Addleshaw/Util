//
//  BannerScrollView.h
//  return
//
//  Created by Bernie on 2017/6/30.
//  Copyright © 2017年 Bernie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BannerScrollView : UIScrollView<UIScrollViewDelegate>{
    
    NSMutableArray*_list;
    int current;
}

@property(nonatomic,strong)NSArray*imgList;//@[@"图片地址"...]

@property(nonatomic,copy)void(^viewAction)(int,int); //(事件类型 0:点击 1:滚动, 当前展示下标)

@end
