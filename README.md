# MLSOAppDelegate

[![Build Status](https://travis-ci.org/alexsun/MLSOAppDelegate.svg)](https://travis-ci.org/alexsun/MLSOAppDelegate)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/MLSOAppDelegate.svg)](https://img.shields.io/cocoapods/v/MLSOAppDelegate.svg)
[![Platform](https://img.shields.io/cocoapods/p/MLSOAppDelegate.svg?style=flat)](http://cocoadocs.org/docsets/MLSOAppDelegate)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

## Introduction

A better implementation for service-oriented app delegate.

- **More loosely coupled** 

    Using `MLSOAppDelegate`, you can implement remote push-notifications in another class separately without any other modification.

- **More cleaner**

    `MLSOAppDelegate` forwards all `<UIApplicationDelegate>` calls to the registed service objects at runtime. It does not implement any `<UIApplicationDelegate>` methods actually. So, you DO NOT need to add "remote-notification" to the list of 
your supported UIBackgroundModes in your Info.plist, if you did not implemented `-[<UIApplicationDelegate> application:didReceiveRemoteNotification:fetchCompletionHandler:]`.

<a id="installation"></a>
## Installation

### [Cocoapods](https://cocoapods.org/)

#### Podfile

To integrate MLSOAppDelegate into your Xcode project using CocoaPods, specify it in your Podfile:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '7.0'

target 'TargetName' do
pod 'MLSOAppDelegate', '~> 0.0.1'
end
```

Then, run the following command:

```bash
$ pod install
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

To integrate MLSOAppDelegate into your Xcode project using Carthage, specify it in your `Carfile`:

```ogdl
github "alexsun/MLSOAppDelegate" ~> 0.0.1 
```

Run `carthage` to build the framework and drag the built `MLSOAppDelegate.framework` into your Xcode project.

### Manually

If you prefer not to use either of the above mentioned dependency managers, you can integrate `SOAppDelegate` into your project manually by adding the files contained in the [Source](https://github.com/alexsun/MLSOAppDelegate/tree/master/Source) folder to your project.

## Usage

### Integrate MLSOAppDelegate

Let's start with an empty project.

1. [Create an empty project with Xcode](https://developer.apple.com/library/mac/recipes/xcode_help-structure_navigator/articles/Creating_a_Project.html);

2. [Install MLSOAppDelegate](#installation);

3. Remove `AppDelegate.h` and `AppDelegate.m` files.

4. Open `main.m`, replace `AppDelegate` with `MLSOAppDelegate`:

    ```objc
    #import <MLSOAppDelegate/MLSOAppDelegate.h>
    
    int main(int argc, char * argv[]) {
        @autoreleasepool {
            return UIApplicationMain(argc, argv, nil, NSStringFromClass([MLSOAppDelegate class]));
        }
    }
    ```
    
Now, your application can run with MLSOAppDelegate. It's ready to implement services.

### Services

#### What is a service?

Every business that depends on <UIApplicationDelegate> is a service. Such as remote notification, local notification, facebook authentication, qq authentication, handle open url, data protection, state restoration, user activity continuation, etc.

#### Implement Services

The following code is an implementation for the remote notification service.

```objc
#import "MLSOAppDelegate.h"

// adopt MLAppService protocol
@interface NotificationService : NSObject <MLAppService>
@end

@implementation NotificationService

// register the service
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
    // upload the deviceToken to your servers
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
}

@end
```

### Inherit MLSOAppDelegate class

You may want to create subclass of MLSOAppDelegate. There is a precaution. **If you implement any UIApplicationDelegate method, DO NOT forget to call the super to ensure all the service implementation get called.**

```objc
@interface AppDelegate : MLSOAppDelegate
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
```

## License

MLSOAppDelegate is available under the MIT license. See the LICENSE file for more info.
