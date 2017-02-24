//
// Copyright (c) 2016 and Confidential to Pegasystems Inc. All rights reserved.
//

@import UIKit;
@import PMBase;
@import PMAuthentication;

@interface AppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, nonnull) NSURL *instanceURL;

@property (nonatomic, nonnull) NSString *instanceUsername;

@property (nonatomic, nonnull) NSString *instancePassword;

@property (nonatomic, nonnull) UIWindow *window;

- (void)logInWithUsername:(nonnull NSString *)username
                 password:(nonnull NSString *)password
        completionHandler:(nonnull void (^)(NSDictionary<NSString *, id> *_Nullable json, NSError *_Nullable error))completionHandler;

- (void)logout;

@end
