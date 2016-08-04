//
//  NotificationService.m
//  Demo
//
//  Created by Sun Jin on 16/7/28.
//  Copyright © 2016年 jsun. All rights reserved.
//

#import "NotificationService.h"

@implementation NotificationService

ML_EXPORT_SERVICE(notifcation)

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if (launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey]) {
        NSLog(@"App was launched by remote notification.");
    } else if (launchOptions[UIApplicationLaunchOptionsLocalNotificationKey]) {
        NSLog(@"App was launched by local notification.");
    }
    [self registerUserNotifications];
    return YES;
}


- (void)registerUserNotifications {
    UIUserNotificationType types = (UIUserNotificationTypeBadge|
                                    UIUserNotificationTypeSound|
                                    UIUserNotificationTypeAlert);
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"%@ %@", NSStringFromSelector(_cmd), deviceToken);
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"%@ %@", NSStringFromSelector(_cmd), error);
}
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    NSLog(@"%@ %@", NSStringFromSelector(_cmd), notificationSettings);
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"%@ %@", NSStringFromSelector(_cmd), userInfo);
    [self.class alertNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"%@ %@", NSStringFromSelector(_cmd), userInfo);
    [self.class alertNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)alertNotification:(NSDictionary *)userInfo {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Remote Notification" message:userInfo.description delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

@end
