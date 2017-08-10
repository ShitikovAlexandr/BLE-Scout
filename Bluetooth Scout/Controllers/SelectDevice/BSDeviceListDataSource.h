//
//  BSDeviceListDataSource.h
//  Bluetooth Scout
//
//  Created by alex on 06.08.17.
//  Copyright © 2017 Scythgames. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BSBLEManager.h"

@interface BSDeviceListDataSource : NSObject

- (instancetype)initWithTableView:(UITableView*)tableView target:(UIViewController*)target;
- (void)scan;
- (void)updateData;

@end
