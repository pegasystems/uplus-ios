//
// Copyright (c) 2016 and Confidential to Pegasystems Inc. All rights reserved.
//

@import UIKit;

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameInput;

@property (weak, nonatomic) IBOutlet UITextField *passwordInput;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end
