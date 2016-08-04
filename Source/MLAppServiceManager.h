//
//  MLAppServiceManager.h
//  MLAppServiceLoader
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define ML_EXPORT_SERVICE(name) \
+ (void)load {[[MLAppServiceManager sharedManager] registerService:[self new]];} \
- (NSString *)serviceName { return @#name; }

NS_ASSUME_NONNULL_BEGIN

@protocol MLAppService <UIApplicationDelegate>

@required
- (NSString *)serviceName;

@end

@interface MLAppServiceManager : NSObject

+ (instancetype)sharedManager;

- (void)registerService:(id<MLAppService>)service;

- (BOOL)proxyCanResponseToSelector:(SEL)aSelector;
- (void)proxyForwardInvocation:(NSInvocation *)anInvocation;

@end

NS_ASSUME_NONNULL_END
