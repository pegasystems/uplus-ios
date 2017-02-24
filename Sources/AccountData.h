//
// Copyright (c) 2016 and Confidential to Pegasystems Inc. All rights reserved.
//

@import Foundation;
@class TransactionData;

@interface AccountData : NSObject

@property (nonatomic) NSString *name;

@property (nonatomic) NSString *balanceMain;

@property (nonatomic) NSString *balanceDecimal;

@property (nonatomic) NSString *availableCredit;

@property (nonatomic) NSString *minPayment;

@property (nonatomic) NSString *rewards;

@property (nonatomic) NSString *info;

@property (nonatomic) NSArray<TransactionData *> *transactions;

@end
