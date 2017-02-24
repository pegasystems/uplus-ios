//
// Copyright (c) 2016 and Confidential to Pegasystems Inc. All rights reserved.
//

@import UIKit;
#import "AccountInfoTableViewCell.h"
#import "AccountSecondaryInfoTableViewCell.h"
#import "TransactionDetailsViewController.h"
@class AccountData;

@interface AccountDetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *detailsTableView;

@property (nonatomic) AccountData *account;

@end
