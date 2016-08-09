//
//  RootUIService.m
//  Demo
//
//  Created by Sun Jin on 16/8/8.
//  Copyright © 2016年 jsun. All rights reserved.
//

#import "RootUIService.h"
#import "ViewController.h"

@implementation RootUIService

ML_EXPORT_SERVICE(rootUI)

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    application.delegate.window = window;
    
    ViewController* dvc = [[ViewController alloc] init];
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:dvc];
    window.rootViewController = nav;
    [window makeKeyAndVisible];
    return YES;
}

@end
