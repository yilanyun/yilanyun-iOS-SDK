//
//  AppDelegate.m
//  YLUISDKDemo
//
//  Created by leihaojie on 2019/8/16.
//  Copyright © 2019 leihaojie. All rights reserved.
//

#import "AppDelegate.h"
#import <YLUISDK/YLUISDK-Swift.h>
#import <BUAdSDK/BUAdSDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /**
     初始化SDK
     @param key : key由一览提供
     @param token : token由一览提供
     @param sid : 设置渠道号
     @param uid : 为了获取更加准确的跨平台的个性化推荐内容，鼓励用户配置应用的唯一userId
     */
    [YLInit.shared setAccessKey:@"ylel2vek386q" token:@"talb5el4cbw3e8ad3jofbknkexi1z8r4" sid:@"test" uid:@"100"];
    
    // SDK Debug信息开关, 默认关闭
    YLInit.shared.debugMode = YES;
    // 设置穿山甲AppID
    [BUAdSDKManager setAppID:@"5029130"];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
