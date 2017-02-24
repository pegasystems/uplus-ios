//
// Copyright (c) 2016 and Confidential to Pegasystems Inc. All rights reserved.
//

@import PMAuthentication;
#import "LoginViewController.h"
#import "AppDelegate.h"

@interface LoginViewController ()
@end

@implementation LoginViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.usernameInput.text = delegate.instanceUsername;
    self.passwordInput.text = delegate.instancePassword;

    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 50)];
    self.usernameInput.leftView = paddingView;
    self.usernameInput.leftViewMode = UITextFieldViewModeAlways;
    UIView *passwdPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 50)];

    self.passwordInput.leftView = passwdPaddingView;
    self.passwordInput.leftViewMode = UITextFieldViewModeAlways;

    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture)];
    [self.view addGestureRecognizer:tapRecognizer];

    [self setNeedsStatusBarAppearanceUpdate];

    self.activityIndicator.hidden = YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)loginClicked:(id)sender {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [delegate
        logInWithUsername:self.usernameInput.text
                 password:self.passwordInput.text
        completionHandler:^(NSDictionary<NSString *, id> *_Nullable json, NSError *_Nullable error) {

            if (!error) {
                [self performSegueWithIdentifier:@"LoginSuccessfull" sender:self];
                self.activityIndicator.hidden = YES;
                self.loginButton.hidden = NO;
                [self.activityIndicator stopAnimating];
            } else {
                self.activityIndicator.hidden = YES;
                self.loginButton.hidden = NO;
                [self.activityIndicator stopAnimating];

                UIAlertController *alert =
                    [UIAlertController alertControllerWithTitle:@"Login error" message:@"Authentication failed" preferredStyle:UIAlertControllerStyleAlert];

                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:ok];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }];

    self.loginButton.hidden = YES;
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self handleTapGesture];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [[[UIApplication sharedApplication] delegate] window].rootViewController = segue.destinationViewController;
}

#pragma mark Text Field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)handleTapGesture {
    [self.view endEditing:YES];
}

@end
