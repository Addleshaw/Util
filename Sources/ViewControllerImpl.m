//
//  ViewControllerImpl.m
//  BaseProject
//
//  Created by beinie on 15/7/2.
//  Copyright (c) 2013年 lingzerg. All rights reserved.
//

#import "ViewControllerImpl.h"



@interface ViewControllerImpl (){
    NSMutableDictionary*URLSessionDataTaskList;
//    RZSquaresLoading*loddingview;
}

@end


@implementation ViewControllerImpl

- (void)viewDidLoad
{
    [super viewDidLoad];
    URLSessionDataTaskList = [NSMutableDictionary new];
    _autoHideKeyBorad = NO;
//    self.navigationItem.backBarButtonItem = nil;
//    if (self.navigationController.viewControllers.count>1) {
////        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"goodsxqback"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(popback)];
//        
//        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(popback)];
//    }
    
    
//    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}
-(BOOL)hidesBottomBarWhenPushed{
    return YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    for (NSURLSessionDataTask*dt in URLSessionDataTaskList.allValues) {
        [dt cancel];
    }
}
-(void)popback{
    [self hideKeyBorad];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)reloadView{

}


-(void)get:(NSDictionary *)adic complete:(RequestCompleteBlock)complete{
    
    NSMutableDictionary*dic = [[NSMutableDictionary alloc]initWithDictionary:adic];
    [dic setValue:[User userName]?[User userName]:@"" forKey:@"email"];
    [dic setValue:[User userPwd]?[User userPwd]:@"" forKey:@"pwd"];
    
    //移除作为block回调参数用的key
    [dic removeObjectForKey:@"block"];
    [AFNetworkingTool getWithURLString:[NSString stringWithFormat:@"%@",BaseSuffix] parameters:dic success:^(id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            DataResult*r = [DataResult getResultFromDic:responseObject];
            if(!r.status){
                [self showHint:r.errorMsg];
            }
            complete(r);
        }
    } failure:^(NSError *error) {
        [self showHint:[error.userInfo valueForKey:@"NSLocalizedDescription"]];
        complete([DataResult getResultFromDic:@{}]);
    }];
    
}
-(void)post:(NSDictionary *)adic complete:(RequestCompleteBlock)complete{
    NSMutableDictionary*dic = [[NSMutableDictionary alloc]initWithDictionary:adic];
    [dic setValue:[User userName]?[User userName]:@"" forKey:@"email"];
    [dic setValue:[User userPwd]?[User userPwd]:@"" forKey:@"pwd"];
    
    //移除作为block回调参数用的key
    [dic removeObjectForKey:@"block"];
    [AFNetworkingTool postWithURLString:[NSString stringWithFormat:@"%@",BaseSuffix] parameters:dic success:^(id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            DataResult*r = [DataResult getResultFromDic:responseObject];
            if(!r.status){
                [self showHint:r.errorMsg];
            }
            complete(r);
        }else{
            complete([DataResult getResultFromDic:@{}]);
        }
    } failure:^(NSError *error) {
        [self showHint:[error.userInfo valueForKey:@"NSLocalizedDescription"]];
        complete([DataResult getResultFromDic:@{}]);
    }];
}





-(void)Init{
    self.edgesForExtendedLayout = UIRectEdgeNone;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self Init];
    }
    return self;
}
- (id)init
{
    self = [super init];
    if (self) {
        [self Init];
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self Init];
    }
    return self;
}

-(void)startLodding{
//    loddingview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 36, 36)];
//    loddingview.color = [UIColor greenColor];
//    loddingview.center = CGPointMake(SCREEN_WIDTH/2, self.view.center.y-70);
//    [self.view addSubview:loddingview];
}
-(void)endLodding{
//    [loddingview removeFromSuperview];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (_autoHideKeyBorad) {
        [self hideKeyBorad];
    }
}
-(void)hideKeyBorad{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];    
}


@end
