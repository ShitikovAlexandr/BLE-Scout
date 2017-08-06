//
//  ViewController.m
//  Bluetooth Scout
//
//  Created by Alex on 22.07.17.
//  Copyright © 2017 Scythgames. All rights reserved.
//

#import "ViewController.h"
#import "BSBLEManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [BSBLEManager sharedManager];
}

- (IBAction)scanAction:(id)sender {
    [[BSBLEManager sharedManager] scanForDevice];
}

@end
