//
//  MBProgressHUD+Alert.m
//  WealthCloud
//
//  Created by fanxiaobin on 2017/4/19.
//  Copyright © 2017年 caifumap. All rights reserved.
//

#import "MBProgressHUD+Alert.h"
#define kMBProgressHUDDelayTimeInterval     2.0

@implementation MBProgressHUD (Alert)

+ (UIWindow *)keyWindow{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (window == nil) {
        window = [UIApplication sharedApplication].windows.firstObject;
    }
    return window;
}

+(MBProgressHUD *)showAlert:(NSString *)text{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[MBProgressHUD keyWindow] animated:YES];
    hud.label.text = text;
    hud.label.font = kFont(kSCALE(40.0));
    hud.mode = MBProgressHUDModeText;
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.color = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.9];;
    hud.bezelView.style = MBProgressHUDBackgroundStyleBlur;
    [hud hideAnimated:YES afterDelay:1.5];
    
    return hud;
    
}

+(MBProgressHUD *)showLoadingWithText:(NSString *)text{
    HiddenLoading;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[MBProgressHUD keyWindow] animated:YES];
    hud.label.text = text;
    hud.label.font = kFont(kSCALE(50.0));
    hud.mode = MBProgressHUDModeText;
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.color = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.9];;
    hud.bezelView.style = MBProgressHUDBackgroundStyleBlur;

    return hud;
}

+ (void)hiddenHUD{
   [MBProgressHUD hideHUDForView:[MBProgressHUD keyWindow] animated:YES];
}

@end
