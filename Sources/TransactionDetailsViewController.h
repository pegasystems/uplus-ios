//
// Copyright (c) 2016 and Confidential to Pegasystems Inc. All rights reserved.
//

@import UIKit;
@class TransactionData;

@interface TransactionDetailsViewController : UIViewController

@property (nonatomic) TransactionData *transaction;

@property (weak, nonatomic) IBOutlet UILabel *txTitle;

@property (weak, nonatomic) IBOutlet UIButton *disputeButton;

@property (weak, nonatomic) IBOutlet UITableView *detailsTable;

@end
