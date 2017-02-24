//
// Copyright (c) 2016 and Confidential to Pegasystems Inc. All rights reserved.
//


@import Foundation;
@class AccountData;

@interface DemoDataSource : NSObject

@property (nonatomic) NSMutableArray<AccountData *> *savings;

@property (nonatomic) NSMutableArray<AccountData *> *loans;

@property (nonatomic) NSMutableArray<AccountData *> *cards;

@end
