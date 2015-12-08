//
//  AppDelegate.m
//  parse test
//
//  Created by Marco Hung on 25/12/2014.
//  Copyright (c) 2014年 Ceasar Production. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /* ----- parse init----- */
    // [Optional] Power your app with Local Datastore. For more info, go to
    // https://parse.com/docs/ios_guide#localdatastore/iOS
    [Parse enableLocalDatastore];
    
    // Initialize Parse.
    [Parse setApplicationId:@"fHEHoKfaIUSbquVGCOvu0qbPxcEu3sX9ZllgkxYH"
                  clientKey:@"cwPtaJQW1LrsCtUR8atGcg2K7447akyDEDrUBwYP"];
    
    // [Optional] Track statistics around application opens.
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    // Override point for customization after application launch.
     /* ----- parse init----- */
    
    /* ----- plist local storage init ----- */
    //plist - move to document
    NSFileManager *fm = [[NSFileManager alloc] init];
    
    NSString *src = [[NSBundle mainBundle] pathForResource:@"cardmemory" ofType:@"plist"];
    NSString *dst = [NSString stringWithFormat:@"%@/Documents/cardmemory.plist", NSHomeDirectory()];
    if (![fm fileExistsAtPath:dst]){
        [fm copyItemAtPath:src toPath:dst error:nil];
    }
    
    //change nagvigation bar color
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:(0/255.f) green:(170/255.f) blue:(193/255.f) alpha:(1.0f)]];
    // This sets the text color of the navigation links
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    // This sets the title color of the navigation bar
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    //change tab bar color
    [[UITabBar appearance] setBarTintColor:[UIColor colorWithRed:(0/255.f) green:(72/255.f) blue:(82/255.f) alpha:(1.0f)]];
    //set tab bar icon SELECTED color
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:(164/255.f) green:(208/255.f) blue:(2/255.f) alpha:(1.0f)]];
    //set tab bar text UNSELECETED color
    [UITabBarItem.appearance setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}forState:UIControlStateNormal];
    //set tab bar text SELECTED color
    [UITabBarItem.appearance setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:(164/255.f) green:(208/255.f) blue:(2/255.f) alpha:(1.0f)]}forState:UIControlStateSelected];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
