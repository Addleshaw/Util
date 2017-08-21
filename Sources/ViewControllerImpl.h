//
//  ViewControllerImpl.h
//  BaseProject
//
//  Created by beinie on 15/7/2.
//  Copyright (c) 2013年 lingzerg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh/MJRefresh.h>
#import "DataResult.h"
#import "MLMBaseViewController.h"

#define COMPLETE_BLOCK void(^)(BOOL b,CGDataResult *r)
#define EXECUTE_BLOCK CGDataResult *(^)(ASIHTTPRequest * request)

typedef void(^RequestCompleteBlock)(DataResult *r);


@interface ViewControllerImpl : MLMBaseViewController<UIGestureRecognizerDelegate>{
    
}
-(void)Init;





-(void)get:(NSDictionary *)adic complete:(RequestCompleteBlock)complete;
-(void)post:(NSDictionary *)adic complete:(RequestCompleteBlock)complete;



@property BOOL autoHideKeyBorad;
-(void)hideKeyBorad;
-(void)popback;

-(void)startLodding;
-(void)endLodding;

@end
