//
// Copyright (c) 2016 and Confidential to Pegasystems Inc. All rights reserved.
//

#import "TransactionDetailsViewController.h"
#import "DisputeNavigationController.h"
#import "TransactionAmountTableViewCell.h"
#import "TransactionData.h"
#import "TransactionInfoTableViewCell.h"

@interface TransactionDetailsViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation TransactionDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.disputeButton.layer.cornerRadius = 5;
    self.disputeButton.layer.borderWidth = 2;
    self.disputeButton.layer.borderColor = self.disputeButton.backgroundColor.CGColor;
    self.detailsTable.delegate = self;
    self.detailsTable.dataSource = self;
    self.detailsTable.bounces = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.txTitle setText:[self.transaction name]];
}

- (IBAction)disputeTapped:(id)sender {
    DisputeNavigationController *diputeNC = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([DisputeNavigationController class])];
    [self presentViewController:diputeNC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark UITableViewDatasource methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
        return 100.0;
    }
    return 50.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
        TransactionAmountTableViewCell *cell =
            (TransactionAmountTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"TransactionAmountTableViewCell"];
        [[cell mainBalanceLabel] setText:self.transaction.amountMain];
        [[cell decimalBalanceLabel] setText:self.transaction.amountDecimal];
        return cell;
    } else {

        TransactionInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TransactionInfoTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        switch (indexPath.row) {
        case 1:
            [[cell name] setText:@"Date"];
            [[cell value] setText:[self.transaction date]];
            break;
        case 2:
            [[cell name] setText:@"Date posted"];
            [[cell value] setText:[self.transaction datePosted]];
            break;
        case 3:
            [[cell name] setText:@"Reference number"];
            [[cell value] setText:[self.transaction referenceNumber]];
            break;
        default:
            break;
        }

        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

@end
