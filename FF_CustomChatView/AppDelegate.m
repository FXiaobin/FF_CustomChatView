//
//  AppDelegate.m
//  FF_CustomChatView
//
//  Created by fanxiaobin on 2017/5/31.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "AppDelegate.h"
#import "ConversationListViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[ConversationListViewController new]];
    
    
    EMOptions *options = [EMOptions optionsWithAppkey:@"1145170531115494#liaoliao"];
    options.apnsCertName = @"istore_dev";
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    
//    EMError *error = [[EMClient sharedClient] registerWithUsername:@"fan123" password:@"123456"];
//    if (error==nil) {
//        NSLog(@"注册成功");
//    }
    
    NSString *username = @"fan123";
    [[NSUserDefaults standardUserDefaults] setObject:username forKey:@"username"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    EMError *error = [[EMClient sharedClient] loginWithUsername:username password:@"123456"];
    if (!error) {
        ShowAlert(@"登录成功");
    }
    
    //添加好友设置代理
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
    
    return YES;
}
//添加好友代理方法
- (void)friendRequestDidReceiveFromUser:(NSString *)aUsername message:(NSString *)aMessage{
    
    NSString *message = [NSString stringWithFormat:@"来自%@的好友请求",aUsername];
    [UIViewUtils showAlertWithTitle:@"好友请求" message:message targetVC:self.window.rootViewController ensureActionTitle:@"同意" completeBlock:^(id obj) {
        
        EMError *aError = [[EMClient sharedClient].contactManager acceptInvitationForUsername:aUsername];
        if (!aError){
            ShowAlert(@"添加成功,已成为好友");
        }else{
            ShowAlert(@"添加失败");
        }
        
        
    } isShowCancelAction:YES];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
