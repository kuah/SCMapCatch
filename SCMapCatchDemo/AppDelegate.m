//
//  AppDelegate.m
//  SCMapCatchDemo
//
//  Created by 陈世翰 on 17/2/23.
//  Copyright © 2017年 Coder Chan. All rights reserved.
//

#import "AppDelegate.h"
#import "SCMapCatch.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    ///Example 1 Dictionary's getting key by path
    NSDictionary *dic = @{@"1":@{@"b":@{@"5":@6}}};
//    id catchResult = [dic mc_objectForKey:@"1.b.5" separatedString:@"."];
    id catchResult = [dic mc_objectForKeys:@"1",@"b",@"5",nil];
    NSLog(@"**************************  example 1  **************************\n----> %@\n\n\n\n\n",catchResult);
    
    ///Example 2  MutableDictionary remove key by setting nil value
    NSMutableDictionary *mDictionary = MDictionary_((@{@"1":@"a",@"2":@"b"}));
    [mDictionary mc_setObject:nil forKey:@"1"];
    NSLog(@"**************************  example 2  **************************\n----> %@\n\n\n\n\n",mDictionary);
    
    
    ///Example 3 UserDefaults Settings
    NSLog(@"**************************  example 3  *************************\n----> before setting: \n---------->my_root : %@\n---------->your_root : %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"my_root"],[[NSUserDefaults standardUserDefaults] objectForKey:@"your_root"]);
    
    
    BOOL set_mine_success = [NSUserDefaults mc_setObject:@"click like btn ^_^" forKey:@"my_root.mm.cc" separatedString:@"."];
    //equal to ->:
    BOOL set_yours_success = [NSUserDefaults mc_setObject:@"click like btn ^_^" forKey:@[@"your_root",@"m",@"c"] separatedString:nil];
    
    
    NSLog(@"example 3 ----> after setting: \n---------->my_root : %@\n---------->your_root : %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"my_root"],[[NSUserDefaults standardUserDefaults] objectForKey:@"your_root"]);
    NSLog(@"set mine success : %d\nset yours success:%d \n\n\n\n\n",set_mine_success,set_yours_success);
    
    
    ///Example 4 UserDefaults' getting by path
    NSString *getting_result = [NSUserDefaults mc_objectForKey:@"your_root/m/c" separatedString:@"/"];
    NSLog(@"**************************  example 4  *************************\n---->获取路径your_root-->m-->c 上的内容 : %@",getting_result);
    
    
    
    [self _clearUD];
    return YES;
}

-(void)_clearUD{
    [NSUserDefaults mc_setObject:nil forKey:@"my_root"];
    [NSUserDefaults mc_setObject:nil forKey:@"your_root"];
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
