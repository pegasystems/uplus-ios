//
// Copyright (c) 2016 and Confidential to Pegasystems Inc. All rights reserved.
//

@import UIKit;

@interface AccountInfoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *mainBalanceLabel;

@property (weak, nonatomic) IBOutlet UILabel *decimalBalanceLabel;

@property (weak, nonatomic) IBOutlet UIButton *paymentButton;

@end
