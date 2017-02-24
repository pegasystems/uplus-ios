//
// Copyright (c) 2016 and Confidential to Pegasystems Inc. All rights reserved.
//

@import Foundation;

@interface TransactionData : NSObject

@property (nonatomic) NSString *name;

@property (nonatomic) NSString *amountMain;

@property (nonatomic) NSString *amountDecimal;

@property (nonatomic) NSString *date;

@property (nonatomic) NSString *datePosted;

@property (nonatomic) NSString *referenceNumber;

@property (nonatomic) NSString *status;

- (NSString *)amountString;

@end
