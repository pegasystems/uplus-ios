//
// Copyright (c) 2016 and Confidential to Pegasystems Inc. All rights reserved.
//

#import "AccountTableViewCell.h"
#import "AccountData.h"

@interface AccountTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *accountNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *mainBalanceLabel;

@property (weak, nonatomic) IBOutlet UILabel *decimalBalanceLabel;

@property (weak, nonatomic) IBOutlet UILabel *balanceDescriptionLabel;

@end

@implementation AccountTableViewCell

- (void)setAccount:(AccountData *)account {
    
    _account = account;
    [self.mainBalanceLabel setText:[account balanceMain]];
    [self.decimalBalanceLabel setText:[account balanceDecimal]];
    [self.balanceDescriptionLabel setText:[account info]];
    [self.accountNameLabel setText:[account name]];
    
}
@end
