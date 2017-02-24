//
// Copyright (c) 2016 and Confidential to Pegasystems Inc. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "MainTabBarController.h"
@import PMBase;

static NSString *kPegaInstanceURL = @"prpc_url";
static NSString *kPegaInstanceUsername = @"prpc_username";
static NSString *kPegaInstancePassword = @"prpc_password";

static NSString *kPegaDefaultUsername = @"user@uplus";
static NSString *kPegaDefaultPassword = @"rules";
static NSString *kPegaDefaultURL = @"https://lab0430.lab.pega.com/prweb";

@interface AppDelegate ()

@property (nonatomic) PMApplicationDelegate *pmDelegate;

@property (nonatomic) PMPegaAuthenticator *authenticator;

@property (nonatomic) LoginViewController *loginViewController;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.pmDelegate = [[PMApplicationDelegate alloc] init];
    [self setupDefaults];
    [[PMLog sharedInstance] setLogLevel:PMLogLevelDebug];
    return [self.pmDelegate application:application willFinishLaunchingWithOptions:launchOptions];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.loginViewController = (LoginViewController *)[[self window] rootViewController];

    if (!self.authenticator) {
        self.authenticator = [[PMPegaAuthenticator alloc] initWithServerURL:self.instanceURL];
        [self.authenticator setLoginActivity:PMPegaAuthenticationLoginActivityMobileAppConfiguration];

    }

    return [self.pmDelegate application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [self.pmDelegate applicationWillResignActive:application];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self.pmDelegate applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [self.pmDelegate applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [self.pmDelegate applicationDidBecomeActive:application];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [self.pmDelegate applicationWillTerminate:application];
}

# pragma mark - Authentication 

- (void)logInWithUsername:(NSString *)username
                 password:(NSString *)password
        completionHandler:(void (^)(NSDictionary<NSString *, id> *_Nullable json, NSError *_Nullable error))completionHandler{
    
    [self.authenticator logInWithUsername:username password:password completionHandler:completionHandler];
    
}

- (void)logout {
    [self.authenticator logOffWithCompletionHandler:^(NSError *_Nullable error) {

        if (error) {
            NSLog(@"Logout completed with error: %@", [error localizedDescription]);
            return;
        }

        NSLog(@"Logout was successfull!");

    }];

    [UIView transitionWithView:self.window
                      duration:0.2
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^(void) {
                        self.window.rootViewController = [self loginViewController];
                    }
                    completion:nil];
}

# pragma mark - Defaults

- (void)setupDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    if (![[defaults stringForKey:kPegaInstanceURL] length]) {
        [defaults setObject:kPegaDefaultUsername forKey:kPegaInstanceUsername];
        [defaults setObject:kPegaDefaultURL forKey:kPegaInstanceURL];
        [defaults setObject:kPegaDefaultPassword forKey:kPegaInstancePassword];

        self.instanceURL = [NSURL URLWithString:kPegaDefaultURL];
        self.instanceUsername = kPegaDefaultUsername;
        self.instancePassword = kPegaDefaultPassword;

    } else {
        self.instanceURL = [NSURL URLWithString:[defaults objectForKey:kPegaInstanceURL]];
        self.instanceUsername = [defaults objectForKey:kPegaInstanceUsername];
        self.instancePassword = [defaults objectForKey:kPegaInstancePassword];
    }

    [defaults synchronize];
}

@end
