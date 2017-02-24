//
// Copyright (c) 2016 and Confidential to Pegasystems Inc. All rights reserved.
//

#import "AccountDetailsViewController.h"
#import "AccountData.h"
#import "AccountInfoTableViewCell.h"
#import "TransactionData.h"
#import "TransactionTableViewCell.h"

@interface AccountDetailsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableViewCell *activeCell;

@property BOOL showHiglightAfterScroll;

@end

@implementation AccountDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.detailsTableView.bounces = NO;
    self.detailsTableView.delegate = self;
    self.detailsTableView.dataSource = self;
    self.detailsTableView.backgroundColor = [UIColor clearColor];
    self.showHiglightAfterScroll = NO;
    self.detailsTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationItem setTitle:[self.account name]];
}

- (void)viewDidAppear:(BOOL)animated {
    self.navigationController.tabBarController.tabBar.userInteractionEnabled = NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    if (!self.account.transactions.count) {
        return 1;
    }

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    switch (section) {
    case 2:
        return (NSInteger)self.account.transactions.count;
        break;
    case 1:
        return 3;
        break;
    default:
        break;
    }

    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if (section == 2) {
        return 50.0;
    }

    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    if (section == 2) {
        UITableViewCell *header = [tableView dequeueReusableCellWithIdentifier:@"AccountActivityHeaderTableViewCell"];
        return header;
    }

    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = nil;

    switch (indexPath.section) {
    case 0:
        cell = [tableView dequeueReusableCellWithIdentifier:@"AccountInfoTableViewCell"];
        [[((AccountInfoTableViewCell *)cell)mainBalanceLabel] setText:self.account.balanceMain];
        [[((AccountInfoTableViewCell *)cell)decimalBalanceLabel] setText:self.account.balanceDecimal];

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        break;
    case 1:
        cell = [tableView dequeueReusableCellWithIdentifier:@"AccountSecondaryInfoTableViewCell"];

        switch (indexPath.row) {
        case 0:
            [[(AccountSecondaryInfoTableViewCell *)cell name] setText:@"Available credit for purchases"];
            [[(AccountSecondaryInfoTableViewCell *)cell value] setText:[self.account availableCredit]];
            break;
        case 1:
            [[(AccountSecondaryInfoTableViewCell *)cell name] setText:@"Minimum Payment Due on 06/03/2016"];
            [[(AccountSecondaryInfoTableViewCell *)cell value] setText:[self.account minPayment]];
            break;
        case 2:
            [[(AccountSecondaryInfoTableViewCell *)cell name] setText:@"Rewards Earned in Last Statement"];
            [[(AccountSecondaryInfoTableViewCell *)cell value] setText:[self.account rewards]];
            break;

        default:
            break;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        break;
    case 2: {
        TransactionData *transaction = [self.account.transactions objectAtIndex:(NSUInteger)indexPath.row];
        cell = [self cellForTransaction:transaction];

        if (indexPath.row == 0) {
            self.activeCell = cell;
            return self.activeCell;
        }
    } break;
    default:
        break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    switch (indexPath.section) {
    case 0:
        return 220.0;
        break;
    case 1:
        return 60.0;
    case 2:
        return 95.0;

    default:
        break;
    }

    return 60.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2 && indexPath.row == 0) {
        UITableViewCell *cell = [self.detailsTableView cellForRowAtIndexPath:indexPath];
        [self performSegueWithIdentifier:@"showTransactionDetails" sender:cell];
    }
}

#pragma mark - Cell helpers

- (UITableViewCell *)cellForTransaction:(TransactionData *)transaction {
    TransactionTableViewCell *cell = [self.detailsTableView dequeueReusableCellWithIdentifier:@"TransactionTableViewCell"];
    [cell setTransaction:transaction];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showTransactionDetails"]) {

        if ([sender isKindOfClass:[TransactionTableViewCell class]]) {
            TransactionDetailsViewController *vc = (TransactionDetailsViewController *)[segue destinationViewController];
            [vc setTransaction:[(TransactionTableViewCell *)sender transaction]];
        }
    }
}

@end
