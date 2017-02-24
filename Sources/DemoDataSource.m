//
// Copyright (c) 2016 and Confidential to Pegasystems Inc. All rights reserved.
//


#import "DemoDataSource.h"
#import "AccountData.h"
#import "TransactionData.h"

@implementation DemoDataSource

- (instancetype)init {

    if (self = [super init]) {

        // transactions

        TransactionData *trans1 = [[TransactionData alloc] init];
        [trans1 setName:@"DOMINO'S 1802 543-653-4656 CAMBRIDGE MA"];
        [trans1 setAmountMain:@"24"];
        [trans1 setAmountDecimal:@"37"];
        [trans1 setDate:@"Monday, May 30, 2016"];
        [trans1 setDatePosted:@"pending"];
        [trans1 setReferenceNumber:@""];
        [trans1 setStatus:@"Pending"];

        TransactionData *trans2 = [[TransactionData alloc] init];
        [trans2 setName:@"TST* COOK RESTAURANT ARLINGTON MA"];
        [trans2 setAmountMain:@"24"];
        [trans2 setAmountDecimal:@"37"];
        [trans2 setDate:@"Sunday, May 29, 2016"];
        [trans2 setDatePosted:@"04/27/2016"];
        [trans2 setReferenceNumber:@"K6HMHRHQ"];

        TransactionData *trans3 = [[TransactionData alloc] init];
        [trans3 setName:@"BALTIMORE SUN SUBSCRIP 8885391280 TX"];
        [trans3 setAmountMain:@"9"];
        [trans3 setAmountDecimal:@"93"];
        [trans3 setDate:@"Friday, May 27, 2016"];
        [trans3 setDatePosted:@"Monday /2016"];
        [trans3 setReferenceNumber:@"VFVJKXD2"];

        TransactionData *trans4 = [[TransactionData alloc] init];
        [trans4 setName:@"WESTFIELD CO OF WI 608-836-1945 WI"];
        [trans4 setAmountMain:@"157"];
        [trans4 setAmountDecimal:@"25"];
        [trans4 setDate:@"Monday, May 30, 2016"];
        [trans4 setDatePosted:@"Tuesday, May 31, 2016"];
        [trans4 setReferenceNumber:@"D3XNJ66S"];

        NSArray *transactions = @[ trans4, trans1, trans2, trans3 ];

        // savings

        AccountData *ultimate = [[AccountData alloc] init];
        [ultimate setName:@"Ultimate Savings Account"];
        [ultimate setBalanceMain:@"923"];
        [ultimate setBalanceDecimal:@"81"];
        [ultimate setInfo:@"On deposit"];

        AccountData *savingsPlus = [[AccountData alloc] init];
        [savingsPlus setName:@"Savings Plus Account"];
        [savingsPlus setBalanceMain:@"1,122"];
        [savingsPlus setBalanceDecimal:@"43"];
        [savingsPlus setInfo:@"On deposit"];
        [savingsPlus setRewards:@"$ 388.14"];

        self.savings = [[NSMutableArray alloc] init];
        [self.savings addObject:ultimate];
        [self.savings addObject:savingsPlus];

        // loans

        AccountData *checking = [[AccountData alloc] init];
        [checking setName:@"Checking Plus"];
        [checking setBalanceMain:@"0"];
        [checking setBalanceDecimal:@"00"];
        [checking setInfo:@"Amount you owe"];

        self.loans = [[NSMutableArray alloc] init];
        [self.loans addObject:checking];

        // cards

        AccountData *dividend = [[AccountData alloc] init];
        [dividend setName:@"UPlus® Dividend World"];
        [dividend setBalanceMain:@"1,219"];
        [dividend setBalanceDecimal:@"74"];
        [dividend setMinPayment:@"$ 65.27"];
        [dividend setAvailableCredit:@"$ 7,878.00"];
        [dividend setRewards:@"$ 231.27"];
        [dividend setInfo:@"Current balance"];

        [dividend setTransactions:transactions];

        self.cards = [[NSMutableArray alloc] init];
        [self.cards addObject:dividend];
    }

    return self;
}

@end
