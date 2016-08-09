//
//  AppDelegate.m
//  Demo
//
//  Created by Sun Jin on 16/7/28.
//  Copyright © 2016年 jsun. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    ///------------------------------------------------------------------------------------------┐
    // This file is NOT neccessary. You can use MLSOAppDelegate directly, without any subclasses.│
    ///------------------------------------------------------------------------------------------┘
    // Do something before all other app services
    // ...
    
    // MLSOAppDelegate (the super) does not implement -application:didFinishLaunchingWithOptions: actually.
    // It forwards the message to all registered services.
    // You MUST call super to ensure all registered service implementation get called.
    if ([super respondsToSelector:@selector(application:didFinishLaunchingWithOptions:)]) {
        [super application:application didFinishLaunchingWithOptions:launchOptions];
    }
    return YES;
}

@end
