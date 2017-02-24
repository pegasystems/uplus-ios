//
//  AccountDetailsTableView.m
//  Citi Mobile
//
//  Created by Pabian, Norbert on 5/31/16.
//  Copyright © 2016 Pega. All rights reserved.
//

#import "AccountDetailsTableView.h"

@implementation AccountDetailsTableView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [indexPath row] * 20;
}

@end
