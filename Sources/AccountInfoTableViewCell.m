//
// Copyright (c) 2016 and Confidential to Pegasystems Inc. All rights reserved.
//

#import "AccountInfoTableViewCell.h"

@implementation AccountInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.paymentButton.layer.cornerRadius = 5;
    self.paymentButton.layer.borderWidth = 2;
    self.paymentButton.layer.borderColor = self.paymentButton.backgroundColor.CGColor;
}

@end
