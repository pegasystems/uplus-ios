//
// Copyright (c) 2016 and Confidential to Pegasystems Inc. All rights reserved.
//

#import "AccountsViewController.h"
#import "AccountData.h"
#import "AccountDetailsViewController.h"
#import "AccountHeaderTableViewCell.h"
#import "AccountTableViewCell.h"
#import "AppDelegate.h"
#import "DemoDataSource.h"
#import "LoginViewController.h"
#import "TransactionData.h"

@interface AccountsViewController () <UITableViewDelegate, UITableViewDataSource>

@property UITableViewCell *activeCell;

@property DemoDataSource *dataSource;

@end

@implementation AccountsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabBarItem setImage:[UIImage imageNamed:@"accounts"]];
    [self.tabBarItem setSelectedImage:[UIImage imageNamed:@"accounts_selected"]];

    self.accountsTableView.delegate = self;
    self.accountsTableView.dataSource = self;
    self.accountsTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.accountsTableView.bounces = NO;
    self.dataSource = [[DemoDataSource alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    switch (section) {
    case 0:
        return (NSInteger)[[self.dataSource savings] count];
        break;
    case 1:
        return (NSInteger)[[self.dataSource loans] count];
        break;
    case 2:
        return (NSInteger)[[self.dataSource cards] count];
        break;
    default:
        break;
    }

    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForAccount:(AccountData *)account {

    AccountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AccountTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setAccount:account];
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    AccountData *account = nil;
    NSUInteger row = (NSUInteger)indexPath.row;

    switch (indexPath.section) {
    case 0:
        account = [[self.dataSource savings] objectAtIndex:row];
        break;
    case 1:
        account = [[self.dataSource loans] objectAtIndex:row];
        break;
    case 2:
        account = [[self.dataSource cards] objectAtIndex:row];
        self.activeCell = [self tableView:tableView cellForAccount:account];
        return self.activeCell;
        break;
    default:
        break;
    }
    return [self tableView:tableView cellForAccount:account];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    AccountHeaderTableViewCell *head = [tableView dequeueReusableCellWithIdentifier:@"AccountTableViewHeaderCell"];
    [[head titleLabel] setText:[self tableView:tableView titleForHeaderInSection:section]];
    return head;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

    switch (section) {
    case 0:
        return @"SAVINGS";
        break;
    case 1:
        return @"LINES AND LOANS";
        break;
    case 2:
        return @"CREDIT CARDS";
        break;
    default:
        break;
    }
    return @"";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"showAccountDetails" sender:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 50.0;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([[segue identifier] isEqualToString:@"showAccountDetails"]) {
        AccountDetailsViewController *vc = (AccountDetailsViewController *)[segue destinationViewController];

        AccountData *account = nil;
        NSIndexPath *indexPath = (NSIndexPath *)sender;
        NSUInteger row = (NSUInteger)[indexPath row];

        switch (indexPath.section) {
        case 0:
            account = [[self.dataSource savings] objectAtIndex:row];
            break;
        case 1:
            account = [[self.dataSource loans] objectAtIndex:row];
            break;
        case 2:
            account = [[self.dataSource cards] objectAtIndex:row];
            break;
        default:
            break;
        }

        [vc setAccount:account];
    }
}

- (IBAction)singOffClicked:(id)sender {
    [(AppDelegate *)[UIApplication sharedApplication].delegate logout];
}

@end
