//
// Copyright (c) 2016 and Confidential to Pegasystems Inc. All rights reserved.
//

#import "TransactionData.h"

@implementation TransactionData

- (NSString *)amountString {

    return [NSString stringWithFormat:@"$ %@.%@", self.amountMain, self.amountDecimal];
}

@end
