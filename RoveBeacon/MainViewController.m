//
//  MainViewController.m
//  RoveBeacon
//
//  Created by Maxwell Folley on 6/21/14.
//  Copyright (c) 2014 Rove. All rights reserved.
//

#import "MainViewController.h"


@interface MainViewController () {
    NSUUID *_uuid;
    int _minor;
}
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.beaconOneButton.backgroundColor = [UIColor colorWithRed:241.0/255.0 green:196.0/255.0 blue:15.0/255.0 alpha:1.0];
    self.beaconOneButton.titleLabel.textColor = [UIColor whiteColor];
    
    self.beaconTwoButton.backgroundColor = [UIColor colorWithRed:46.0/255.0 green:204.0/255 blue:113.0/255.0 alpha:1.0];
    self.beaconTwoButton.titleLabel.textColor = [UIColor whiteColor];
    
    _uuid = [[NSUUID alloc] initWithUUIDString:@"BC02C8B3-456E-4FEA-8AFE-B7ABC8945291"];
}

- (void)viewWillLayoutSubviews
{
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)beaconOneTapped:(id)sender {
    _minor = 1;
    [self startBroadcasting];
}

- (IBAction)beaconTwoTapped:(id)sender {
    _minor = 2;
    [self startBroadcasting];
}

- (void)startBroadcasting
{
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:_uuid
                                                                major:1
                                                                minor:_minor
                                                           identifier:@"com.rover.pdx"];
    // Get the beacon data to advertise
    self.beaconData = [self.beaconRegion peripheralDataWithMeasuredPower:nil];
    
    // Start the peripheral manager
    self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self
                                                                     queue:nil
                                                                   options:nil];
}

-(void)peripheralManagerDidUpdateState:(CBPeripheralManager*)peripheral
{
    if (peripheral.state == CBPeripheralManagerStatePoweredOn)
    {
        // Bluetooth is on
        
        // Update our status label
        self.statuslabel.text = [NSString stringWithFormat:@"Broadcasting Beacon %i", _minor];
        
        // Start broadcasting
        [self.peripheralManager startAdvertising:self.beaconData];
    }
    else if (peripheral.state == CBPeripheralManagerStatePoweredOff)
    {
        // Update our status label
        self.statuslabel.text = @"Stopped";
        
        // Bluetooth isn't on. Stop broadcasting
        [self.peripheralManager stopAdvertising];
    }
    else if (peripheral.state == CBPeripheralManagerStateUnsupported)
    {
        self.statuslabel.text = @"Unsupported";
    }
}

@end
