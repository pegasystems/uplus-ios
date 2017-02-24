//
// Copyright (c) 2016 and Confidential to Pegasystems Inc. All rights reserved.
//

#import "DisputeNavigationController.h"
#import "AppDelegate.h"
#import "TransactionDetailsViewController.h"
@import PMBase;

@interface DisputeNavigationController () <PMSnapStartViewControllerDelegate>

@property (nonatomic) PMSnapStartViewController *snapStartController;

@property BOOL webViewRequested;

@property BOOL webViewReady;

@property (nonatomic) NSTimer *timeoutTimer;

@end

@implementation DisputeNavigationController

- (void)startDisputeProcess {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    PMCreateCaseAction *action =
        [[PMCreateCaseAction alloc] initWithPortalURL:[appDelegate instanceURL] flowType:@"pyStartCase" insClass:@"Uplu-UPlusDis-Work-DisputeTransaction"];
    [self.snapStartController performAction:action];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.snapStartController = [[PMSnapStartViewController alloc] init];
    [self.snapStartController.navigationItem setTitle:@"Dispute transaction"];
    [self.snapStartController.navigationItem setHidesBackButton:YES];
    [self.snapStartController setDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!self.webViewRequested) {
        [self startDisputeProcess];
    }
}

- (void)showWebView {

    self.webViewRequested = YES;

    CATransition *transition = [CATransition animation];
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;

    if (self.webViewReady) {
        transition.duration = 0.4;
        [self.view.window.layer addAnimation:transition forKey:nil];
        [self pushViewController:self.snapStartController animated:YES];
    } else {
        transition.duration = 0.1;
        [self.view.window.layer addAnimation:transition forKey:nil];
        self.timeoutTimer = [NSTimer scheduledTimerWithTimeInterval:20.0 target:self selector:@selector(onTimeout:) userInfo:nil repeats:NO];
        [self performSegueWithIdentifier:@"showLoadingVC" sender:self];
    }
}

- (void)onTimeout:(NSTimer *)timer {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - PMSnapStartViewControllerDelegate methods

- (void)snapStartController:(PMSnapStartViewController *)controller didStartAction:(PMSnapStartAction *)action {
    [self.timeoutTimer invalidate];
    self.webViewReady = YES;
    if (self.webViewRequested) {
        [self.presentedViewController dismissViewControllerAnimated:YES
                                                         completion:^{
                                                             CATransition *transition = [CATransition animation];
                                                             transition.duration = 0.4;
                                                             transition.timingFunction =
                                                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                                                             transition.type = kCATransitionFade;
                                                             [self.view.window.layer addAnimation:transition forKey:nil];
                                                             [self pushViewController:self.snapStartController animated:YES];

                                                         }];
    }
}

- (void)snapStartController:(PMSnapStartViewController *)controller didFailAction:(PMSnapStartAction *)action withError:(NSError *)error {

    UIAlertController *alert =
        [UIAlertController alertControllerWithTitle:@"Login error" message:@"Authentication failed" preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:ok];

    if (self.webViewRequested) {
        UIViewController *presenting = self.presentingViewController;
        [presenting dismissViewControllerAnimated:YES
                                       completion:^{
                                           [presenting presentViewController:alert animated:YES completion:nil];
                                       }];
    } else {
        [self popToRootViewControllerAnimated:YES];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)snapStartController:(PMSnapStartViewController *)controller didFinishAction:(PMSnapStartAction *)action {

    UIViewController *presenting =
        [[[[[[UIApplication sharedApplication] delegate] window] rootViewController] presentedViewController] presentingViewController];
    UINavigationController *accountsNC = [[presenting childViewControllers] firstObject];
    [accountsNC popToViewController:[[accountsNC viewControllers] objectAtIndex:1] animated:NO];

    [presenting dismissViewControllerAnimated:YES completion:^{
        self.snapStartController = nil;
    }];
}

- (void)snapStartControllerWebContentProcessDidTerminate:(PMSnapStartViewController *)controller {
}

@end
