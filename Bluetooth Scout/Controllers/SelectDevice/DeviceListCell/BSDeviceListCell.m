//
//  BSDeviceListCell.m
//  Bluetooth Scout
//
//  Created by alex on 07.08.17.
//  Copyright © 2017 Scythgames. All rights reserved.
//

#import "BSDeviceListCell.h"

@implementation BSDeviceListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)addDataToCell:(CBPeripheral*)peripheral {
    self.textLabel.text = peripheral.name;
}
@end
