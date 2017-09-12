//
//  UIAlertView+Category.h
//
//  Created by beinie on 15/7/2.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (Category)

+(void)alertMessage:(NSString*)message;

+(void)alertMessage:(NSString*)message action:(void(^)(int))actions;

+(void)alertMessage:(NSString*)message buttons:(NSArray*)btns action:(void(^)(int))actions;

+(void)alertTitle:(NSString*)title Message:(NSString*)message buttons:(NSArray*)btns action:(void(^)(int))actions;

+(void)alertTitle:(NSString*)title Message:(NSString*)message textFields:(NSArray*)texts buttons:(NSArray*)btns action:(void(^)(int,UIAlertController*))actions;


+(void)actionSheet:(NSString*)title buttons:(NSArray*)btns action:(void(^)(int))actions;
+(void)actionSheet:(NSString*)title Message:(NSString*)message buttons:(NSArray*)btns action:(void(^)(int))actions;
@end



@interface UIViewController (Category)

@end
