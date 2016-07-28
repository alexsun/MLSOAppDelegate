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
    
    // do something before all other app services
    // ...
    
    // MLSOAppDelegate does not implement -application:didFinishLaunchingWithOptions: actually.
    // It will forward the message to all registered services.
    if ([super respondsToSelector:@selector(application:didFinishLaunchingWithOptions:)]) {
        [super application:application didFinishLaunchingWithOptions:launchOptions];
    }
    return YES;
}

@end
