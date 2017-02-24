//
// Copyright (c) 2016 and Confidential to Pegasystems Inc. All rights reserved.
//

#import "DisputeIntroViewController.h"
#import "DisputeNavigationController.h"

@implementation DisputeIntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)onStartTapped:(id)sender {

    if ([self.navigationController isKindOfClass:[DisputeNavigationController class]]) {
        [(DisputeNavigationController *)self.navigationController showWebView];
    }
}

@end
