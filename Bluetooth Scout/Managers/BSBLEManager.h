//
//  BSBLEManager.h
//  Bluetooth Scout
//
//  Created by Alex on 22.07.17.
//  Copyright © 2017 Scythgames. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreBluetooth;
@import QuartzCore;

@interface BSBLEManager : NSObject

+ (BSBLEManager*)sharedManager;

- (void)scanForDevice;

@end
