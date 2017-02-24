//
// Copyright (c) 2016 and Confidential to Pegasystems Inc. All rights reserved.
//

@import UIKit;
#import "TransactionTableViewCell.h"
#import "TransactionData.h"

@interface TransactionTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *value;

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *date;

@property (weak, nonatomic) IBOutlet UILabel *status;

@end

@implementation TransactionTableViewCell

- (void)setTransaction:(TransactionData *)transaction {
    _transaction = transaction;
    [self.title setText:[transaction name]];
    [self.value setText:[transaction amountString]];
    [self.date setText:[transaction date]];
    [self.status setText:[transaction status]];
}

@end
