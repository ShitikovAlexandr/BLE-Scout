//
//  BSBLEManager.m
//  Bluetooth Scout
//
//  Created by Alex on 22.07.17.
//  Copyright © 2017 Scythgames. All rights reserved.
//

#import "BSBLEManager.h"

@interface BSBLEManager () <CBCentralManagerDelegate, CBPeripheralDelegate>
@property (nonatomic, strong) CBCentralManager *centralManager;
@property (nonatomic, strong) CBPeripheral     *polarH7HRMPeripheral;

@property (nonatomic, retain) NSTimer    *pulseTimer;
@property (strong, nonatomic) id target;

@property (strong, nonatomic) NSMutableArray *peripheralArray;


@end

@implementation BSBLEManager

+ (BSBLEManager *)sharedManager {
    static BSBLEManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _peripheralArray = [NSMutableArray new];
    }
    return self;
}

- (void)scanForDevice {
    CBCentralManager *centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    [centralManager scanForPeripheralsWithServices:nil options:nil];
    self.centralManager = centralManager;
}

- (void)stopScan {
    [self.centralManager stopScan];
}

#pragma mark - CBCentralManagerDelegate


- (void)centralManagerDidUpdateState:(CBCentralManager *)central

{
    // Determine the state of the peripheral
    if ([central state] == CBManagerStatePoweredOff) {
        NSLog(@"CoreBluetooth BLE hardware is powered off");
    }
    else if ([central state] == CBManagerStatePoweredOn) {
        NSLog(@"CoreBluetooth BLE hardware is powered on and ready");
        [_centralManager scanForPeripheralsWithServices:nil options:nil];

    }
    else if ([central state] == CBManagerStateUnauthorized) {
        NSLog(@"CoreBluetooth BLE state is unauthorized");
    }
    else if ([central state] == CBManagerStateUnknown) {
        NSLog(@"CoreBluetooth BLE state is unknown");
    }
    else if ([central state] == CBManagerStateUnsupported) {
        NSLog(@"CoreBluetooth BLE hardware is unsupported on this platform");
    }
}

// method called whenever you have successfully connected to the BLE peripheral
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    //[peripheral setDelegate:self];
    //[peripheral discoverServices:nil];
    NSLog(@"%@", peripheral);
}

// CBCentralManagerDelegate - This is called with the CBPeripheral class as its main input parameter. This contains most of the information there is to know about a BLE peripheral.
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    NSString *localName = [advertisementData objectForKey:CBAdvertisementDataLocalNameKey];
    if ([localName length] > 0) {
        NSLog(@"Found the: %@", localName);
//        [self.centralManager stopScan];
//        self.polarH7HRMPeripheral = peripheral;
//        
//        peripheral.delegate = self;
//        [self.centralManager connectPeripheral:peripheral options:nil];
        [_peripheralArray addObject:peripheral];
        NSNotification *notification = [NSNotification notificationWithName:NEW_DEVICE_FOUND object:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];    }
}



#pragma mark - CBPeripheralDelegate

// CBPeripheralDelegate - Invoked when you discover the peripheral's available services.
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    for (CBService *service in peripheral.services) {
        NSLog(@"Discovered service: %@", service.UUID);
        [peripheral discoverCharacteristics:nil forService:service];
    }
}

// Invoked when you discover the characteristics of a specified service.
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    
}

// Invoked when you retrieve a specified characteristic's value, or when the peripheral device notifies your app that the characteristic's value has changed.
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    
}

#pragma mark - CBCharacteristic helpers

- (NSMutableArray*)getCBPeripheralList {
    return  _peripheralArray;
}

@end
