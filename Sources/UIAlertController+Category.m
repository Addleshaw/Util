//
//  UIAlertController+Category.m
//  
//
//  Created by beinie on 15/7/2.
//

#import "UIAlertController+Category.h"


@interface UIAlertControllerManager : NSObject{
    NSMutableArray *_arr;
}

+(UIAlertControllerManager *)shared;

@end

@implementation UIAlertControllerManager

+(UIAlertControllerManager *)shared{
    static UIAlertControllerManager *sh;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sh = [[UIAlertControllerManager alloc]init];
    });
    return sh;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        _arr = [NSMutableArray new];
    }
    return self;
}


-(void)add:(UIAlertController*)vc{
    [_arr addObject:vc];
    if (_arr.count==1) {
        [self showAlert];
    }
}

-(void)showAlert{
    if(_arr.count!=0){
        UIAlertController*vc = _arr.firstObject;
        UIViewController*root = [UIApplication sharedApplication].keyWindow.rootViewController;
        if (root.presentedViewController != nil || root.presentingViewController != nil ) {
            [[self topUIViewController:root] presentViewController:vc animated:YES completion:nil];
        }else{
            [root presentViewController:vc animated:YES completion:nil];
        }
    }
}
-(UIViewController*)topUIViewController:(UIViewController*)vc{
    UIViewController * temp = vc.presentedViewController;
    while (temp.presentedViewController != nil) {
        temp = temp.presentedViewController;
    }
    return temp;
}
-(void)showNext{
    [_arr removeObjectAtIndex:0];
    [self showAlert];
}

@end

@implementation UIAlertController (Category)


+(void)alertMessage:(NSString*)message{
    [self alertMessage:message buttons:@[] action:nil];
}
+(void)alertMessage:(NSString*)message action:(void(^)(int))actions{
    [self alertTitle:nil Message:message buttons:@[] action:(void(^)(int))actions];
}
+(void)alertTitle:(NSString*)title buttons:(NSArray*)btns action:(void(^)(int))actions{
    [self alertTitle:title Message:nil buttons:btns action:(void(^)(int))actions];
}
+(void)alertMessage:(NSString*)message buttons:(NSArray*)btns action:(void(^)(int))actions{
    [self alertTitle:nil Message:message buttons:btns action:(void(^)(int))actions];
}
+(void)alertTitle:(NSString*)title Message:(NSString*)message buttons:(NSArray*)btns action:(void(^)(int))actions{
    [self alertTitle:title Message:message buttons:btns style:UIAlertControllerStyleAlert action:(void(^)(int))actions];
}
+(void)alertTitle:(NSString*)title Message:(NSString*)message textFields:(NSArray*)texts buttons:(NSArray*)btns action:(void(^)(int,UIAlertController*))actions{
    
    UIAlertController*vc = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    for (NSString*s in texts) {
        [vc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = s;
        }];
    }
    if(btns.count==0){
        [vc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (actions) {
                actions(0,vc);
            }
            [UIAlertControllerManager.shared showNext];
        }]];
    }else{
        for (NSString*str in btns) {
            [vc addAction:[UIAlertAction actionWithTitle:str style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (actions) {
                    actions((int)[btns indexOfObject:str],vc);
                }
                [UIAlertControllerManager.shared showNext];
            }]];
        }
    }
    [UIAlertControllerManager.shared add:vc];
}


+(void)actionSheet:(NSString*)title buttons:(NSArray*)btns action:(void(^)(int))actions{
    [self alertTitle:title Message:nil buttons:btns style:UIAlertControllerStyleActionSheet action:(void(^)(int))actions];
}
+(void)actionSheet:(NSString*)title Message:(NSString*)message buttons:(NSArray*)btns action:(void(^)(int))actions{
    [self alertTitle:title Message:message buttons:btns style:UIAlertControllerStyleActionSheet action:(void(^)(int))actions];
}

+(void)alertTitle:(NSString*)title Message:(NSString*)message buttons:(NSArray*)btns style:(UIAlertControllerStyle)style action:(void(^)(int))actions{
    
    UIAlertController*vc = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    if(btns.count==0){
        [vc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (actions) {
                actions(0);
            }
            [UIAlertControllerManager.shared showNext];
        }]];
    }else{
        for (NSString*str in btns) {
            [vc addAction:[UIAlertAction actionWithTitle:str style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (actions) {
                    actions((int)[btns indexOfObject:str]);
                }
                [UIAlertControllerManager.shared showNext];
            }]];
        }
    }
    [UIAlertControllerManager.shared add:vc];
}

@end
@implementation UIViewController(Category)


@end
