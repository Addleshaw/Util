//
//  Categories.h
//
//  Created by beinie on 15/7/2.
//  Copyright (c) 2015年 Bernie. All rights reserved.
//

#ifndef dongbenV3_0_Categories_h
#define dongbenV3_0_Categories_h


#ifndef RGBA
    #define RGBA(R,G,B,A) [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:A]
#endif

#ifndef SCREEN_WIDTH
    #define SCREEN_WIDTH [[UIScreen mainScreen]bounds].size.width
#endif

#ifndef SCREEN_HEIGHT
    #define SCREEN_HEIGHT [[UIScreen mainScreen]bounds].size.height
#endif

#ifndef pushVC
#define pushVC(Controllername) [self.navigationController pushViewController:VCWithNibName(Controllername) animated:YES]
#endif

#ifndef push
#define push(Controller) [self.navigationController pushViewController:Controller animated:YES]
#endif

#ifndef popToRoot
#define popToRoot [self.navigationController popToRootViewControllerAnimated:YES]
#endif

#ifndef pop
#define pop [self.navigationController popViewControllerAnimated:YES]
#endif


#ifndef weakpushVC
#define weakpushVC(Controllername) [__weak_self.navigationController pushViewController:VCWithNibName(Controllername) animated:YES]
#endif

#ifndef weakpush
#define weakpush(Controller) [__weak_self.navigationController pushViewController:Controller animated:YES]
#endif

#ifndef weakpopToRoot
#define weakpopToRoot [__weak_self.navigationController popToRootViewControllerAnimated:YES]
#endif

#ifndef weakpop
#define weakpop [__weak_self.navigationController popViewControllerAnimated:YES]
#endif

#ifndef VCWithNibName
#define VCWithNibName(classname) [[NSClassFromString(classname) alloc]initWithNibName:classname bundle:nil]
#endif

#ifndef    weakify

#define weakify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
autoreleasepool{} __weak __typeof(x) __weak_##x = x; \
_Pragma("clang diagnostic pop")

#endif

#ifndef    strongify

#define strongify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
try{} @finally{} __typeof__(x) x = __weak_##x; \
_Pragma("clang diagnostic pop")

#endif

#import "NSObject+KVO.h"

#import "UIView+Category.h"
#import "UIAlertView+Category.h"
#import "UIAlertController+Category.h"
#import "UIApplication+Category.h"
#import "UIImage+Category.h"
#import "UIColor+Category.h"
#import "UIBarButtonItem+Category.h"
#import "UIButton+Category.h"
#import "UIImageView+Category.h"
#import "UIView+Toast.h"


#import "NSURL+Category.h"
#import "NSString+Pinyin.h"
#import "NSDictionary+Category.h"
#import "NSArray+Category.h"
#import "NSMutableArray+Category.h"
#import "NSString+Category.h"
#import "NSDateFormatter+Category.h"
#import "NSDate+Category.h"
#import "Object+Category.h"

#endif
