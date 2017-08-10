//
//  BSDeviceListCell.h
//  Bluetooth Scout
//
//  Created by alex on 07.08.17.
//  Copyright © 2017 Scythgames. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreBluetooth;


@interface BSDeviceListCell : UITableViewCell


- (void)addDataToCell:(CBPeripheral*)peripheral;
@end
