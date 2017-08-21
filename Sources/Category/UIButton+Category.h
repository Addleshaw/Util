//
//  UIButtonItem+Category.h
//
//  Created by beinie on 15/7/2.
//

#import <UIKit/UIKit.h>
typedef void (^ActionBlock)();
typedef void (^TimeOverBlock)();

@interface UIButton (Category)


-(void)addTarget:(void(^)())targetBlock;

@property (nonatomic, strong) UIColor *normalBackColor;
@property (nonatomic, strong) UIColor *normalTitleColor;
@property (nonatomic, strong) UIColor *waitBackColor;
@property (nonatomic, strong) UIColor *waitTitleColor;


//设置图片在右，文字在左
- (void)setRightImage;

//定时器
- (void)waitAuthCode:(NSInteger)duration completion:(TimeOverBlock)finish;

//等待
- (void)afterTime:(NSInteger)time completion:(TimeOverBlock)finish;


//button
+ (UIButton *)createButtonWithFrame:(CGRect)frame
                              Title:(NSString *)title
                       normaleImage:(UIImage *)normalImage
                        selectImage:(UIImage *)selectImage
                    backGroundColor:(UIColor *)backGroudColor
                         titleColor:(UIColor *)titleColor
                          titleFont:(UIFont *)font
                         buttonType:(UIButtonType)type;
@end
