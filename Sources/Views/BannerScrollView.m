//
//  BannerScrollView.m
//  return
//
//  Created by Bernie on 2017/6/30.
//  Copyright © 2017年 Bernie. All rights reserved.
//

#import "BannerScrollView.h"
#import <UIImageView+WebCache.h>

@implementation BannerScrollView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _list = [NSMutableArray new];
        current = 0;
    }
    return self;
}

-(void)setImgList:(NSArray *)imgList{
    _imgList = imgList;
    if (imgList.count>0) {
        [_list addObjectsFromArray:imgList];
        [_list addObject:imgList.firstObject];
        [_list insertObject:imgList.lastObject atIndex:0];
    }
    self.delegate = self;
    self.bounces = NO;
    self.pagingEnabled = YES;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    [self bulid];
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
}
-(void)tapAction:(UITapGestureRecognizer*)tap{
    if (_viewAction) {
        _viewAction(0,self.contentOffset.x/SCREEN_WIDTH-1);
    }
}
-(void)bulid{
    int index = 0;
    float height = 170;
    for (NSString*src in _list) {
        UIImageView*img = [[UIImageView alloc]initWithFrame:CGRectMake(index*SCREEN_WIDTH, 0, SCREEN_WIDTH, height)];
        img.contentMode = UIViewContentModeScaleAspectFill;
        img.clipsToBounds = YES;
        [img imageWithSrc:src];
        index+=1;
        [self addSubview:img];
    }
    [self setContentSize:CGSizeMake(_list.count*SCREEN_WIDTH, height)];
    [self setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:NO];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    current = scrollView.contentOffset.x/SCREEN_WIDTH;
    if (current==0) {
        [scrollView setContentOffset:CGPointMake((_list.count-2)*SCREEN_WIDTH, 0) animated:NO];
        if (_viewAction) {
            _viewAction(1,(int)_list.count-2);
        }
    }else if (current==_list.count-1){
        [scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:NO];
        if (_viewAction) {
            _viewAction(1,0);
        }
    }else{
        if (_viewAction) {
            _viewAction(1,current-1);
        }
    }
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    current = scrollView.contentOffset.x/SCREEN_WIDTH;
    if (current==0) {
        [scrollView setContentOffset:CGPointMake((_list.count-2)*SCREEN_WIDTH, 0) animated:NO];
        if (_viewAction) {
            _viewAction(1,(int)_list.count-2);
        }
    }else if (current==_list.count-1){
        [scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:NO];
        if (_viewAction) {
            _viewAction(1,0);
        }
    }else{
        if (_viewAction) {
            _viewAction(1,current-1);
        }
    }
}


@end
