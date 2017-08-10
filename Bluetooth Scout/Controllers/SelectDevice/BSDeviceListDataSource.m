//
//  BSDeviceListDataSource.m
//  Bluetooth Scout
//
//  Created by alex on 06.08.17.
//  Copyright © 2017 Scythgames. All rights reserved.
//

#import "BSDeviceListDataSource.h"
#import "BSDeviceListCell.h"
NSString * const identifier = @"Cell";

@interface BSDeviceListDataSource() <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIViewController *target;
@property (strong, nonatomic) NSMutableArray *dataArray;
@end

@implementation BSDeviceListDataSource

- (instancetype)initWithTableView:(UITableView*)tableView target:(UIViewController*)target {
    self = [super init];
    if (self) {
        _dataArray = [NSMutableArray new];
        _target = target;
        _tableView = tableView;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    return self;
}

- (void)scan {
    [[BSBLEManager sharedManager] scanForDevice];
}

- (void)updateData {
    [_dataArray removeAllObjects];
    [_dataArray addObjectsFromArray:[[BSBLEManager sharedManager] getCBPeripheralList]];
    [_tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BSDeviceListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[BSDeviceListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    CBPeripheral *item = [_dataArray objectAtIndex:indexPath.row];
    [cell addDataToCell:item];
    return cell;
}


#pragma mark - UITableViewDelegate


@end
