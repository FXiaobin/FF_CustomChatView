//
//  MBProgressHUD+Alert.h
//  WealthCloud
//
//  Created by fanxiaobin on 2017/4/19.
//  Copyright © 2017年 caifumap. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

#define ShowAlert(text)     [MBProgressHUD showAlert:text]
#define ShowLoading(text)   [MBProgressHUD showLoadingWithText:text]
#define HiddenLoading       [MBProgressHUD hiddenHUD]

@interface MBProgressHUD (Alert)


+ (MBProgressHUD *)showAlert:(NSString *)text;

+ (MBProgressHUD *)showLoadingWithText:(NSString *)text;

+ (void)hiddenHUD;

@end
