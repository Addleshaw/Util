//
//  UIView+ChooseImage.m
//  Yun
//
//  Created by my on 2017/3/6.
//  Copyright © 2017年 lq. All rights reserved.
//

#import "UIView+ChooseImage.h"
#import "TZImagePickerController.h"
#import "UINavigationBar+Awesome.h"
#import "UIImageTool.h"

@implementation UIView (ChooseImage)


+ (void)chooseImageFromeVC:(UIViewController *)vc result:(void(^)(BOOL,UIImage *,NSDictionary *))result {
    [self chooseImageFromeVC:vc max:1 submit:YES pickerAction:nil result:result];
}

+ (void)chooseImageFromeVC:(UIViewController *)vc max:(int)count pickerAction:(void(^)(NSArray<UIImage *>*,NSArray*,BOOL))pickerAction{
    [self chooseImageFromeVC:vc max:count submit:NO pickerAction:pickerAction result:nil];
}
    
+ (void)chooseImageFromeVC:(UIViewController *)vc max:(int)count submit:(BOOL)autoSubmit pickerAction:(void(^)(NSArray*,NSArray*,BOOL))pickerAction result:(void(^)(BOOL,UIImage *,NSDictionary *))result{
        
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:count delegate:nil];
    [imagePickerVc.navigationBar lt_setBackgroundColor:NAVBAR_TINTCOLOR];
    [imagePickerVc.navigationBar setShadowImage:[UIImage new]];
    
    [imagePickerVc.navigationBar setTintColor:[UIColor whiteColor]];
    [imagePickerVc.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        if (pickerAction) {
            pickerAction(photos,assets,isSelectOriginalPhoto);
        }
        if (autoSubmit) {
            TZImagePickerController *cropImageVC = [[TZImagePickerController alloc] initCropTypeWithAsset:assets[0] photo:photos[0] completion:^(UIImage *cropImage, id asset) {
                if (autoSubmit) {
                    NSDictionary *parameter = @{
                                                @"act":@"mall_personal",
                                                @"act_2":@"goamerica",
                                                @"email":[User userName],
                                                @"pwd":[User userPwd],
                                                };
                    [AFNetworkingTool postWithURLString:BaseSuffix parameters:parameter bodyWithBlock:^(id<AFMultipartFormData> formData) {
                        NSData *imageData = [UIImageTool compressImage:cropImage percentage:.5];
                        [formData appendPartWithFileData:imageData name:@"image" fileName:[NSString stringWithFormat:@"image.png"] mimeType:@"image/png"];
                        
                    } success:^(id responseObject) {
                        if (result) {
                            result([responseObject[@"response_code"] integerValue] == 1,cropImage,responseObject);
                        }
                    } failure:^(NSError *error) {
                        [vc showHint:@"请检查网络"];
                    }];
                }
            }];
            cropImageVC.cropRect = CGRectMake(0, (k_height-k_width)/2, k_width, k_width);
            [vc presentViewController:cropImageVC animated:YES completion:nil];
        }
    }];
    [vc presentViewController:imagePickerVc animated:YES completion:nil];
}

@end
