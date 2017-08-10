//
//  BSDeviceListController.m
//  Bluetooth Scout
//
//  Created by alex on 06.08.17.
//  Copyright © 2017 Scythgames. All rights reserved.
//

#import "BSDeviceListController.h"
#import "BSDeviceListDataSource.h"

@interface BSDeviceListController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *scanButton;
@property (strong, nonatomic) BSDeviceListDataSource *dataSource;

@end

@implementation BSDeviceListController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = [[BSDeviceListDataSource alloc] initWithTableView:_tableView target:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateData) name:NEW_DEVICE_FOUND object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NEW_DEVICE_FOUND object:nil];
}


- (IBAction)scanAction:(id)sender {
    [_dataSource scan];
}


- (void)updateData {
    [_dataSource updateData];
}

@end
