
//
//  UIView+Category.h
//
//  Created by beinie on 15/7/2.
//

#import <UIKit/UIKit.h>
typedef void (^TapAction)();

@interface UIView (Category)

- (nullable NSArray*)superviews ;

- (void)fadeOut ;

- (void)fadeOutAndRemoveFromSuperview ;

- (void)fadeIn ;

- (void)removeAllSubviews ;

#pragma mark - Size shortcuts

@property (nonatomic) CGFloat left;

@property (nonatomic) CGFloat top;

@property (nonatomic) CGFloat right;

@property (nonatomic) CGFloat bottom;

@property (nonatomic) CGFloat width;

@property (nonatomic) CGFloat height;

@property (nonatomic) CGFloat centerX;

@property (nonatomic) CGFloat centerY;

@property (nonatomic) CGPoint origin;

@property (nonatomic) CGSize size;

/**
 * Return the coordinate on the screen.
 */
- (CGPoint)clientToScreen:(CGPoint)pt;


- (void)setTapActionWithBlock:(nullable void (^)(void))block;

- (void)setLongPressActionWithBlock:(nullable void (^)(void))block;

- (nullable UIImage *)viewImage;

- (void)addSubViews:(nullable UIView*)views, ...NS_REQUIRES_NIL_TERMINATION;

- (void)tapHandle:(nullable TapAction)block;
- (void)shakeView;
- (void)shakeRotation:(CGFloat)rotation;

-(void)CRadius:(CGFloat)radius;


@end















