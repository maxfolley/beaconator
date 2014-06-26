//
//  MainViewController.h
//  RoveBeacon
//
//  Created by Maxwell Folley on 6/21/14.
//  Copyright (c) 2014 Rove. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface MainViewController : UIViewController <CBPeripheralManagerDelegate>

@property (strong, nonatomic) CBPeripheralManager *peripheralManager;
@property (strong, nonatomic) CLBeaconRegion *beaconRegion;
@property (strong, nonatomic) NSDictionary *beaconData;
@property (strong, nonatomic) IBOutlet UILabel *statuslabel;
@property (strong, nonatomic) IBOutlet UIButton *beaconOneButton;
@property (strong, nonatomic) IBOutlet UIButton *beaconTwoButton;
@property (strong, nonatomic) IBOutlet UIButton *beaconThreeButton;
@property (strong, nonatomic) IBOutlet UIButton *beaconFourButton;
@property (strong, nonatomic) IBOutlet UIButton *beaconFiveButton;
@property (strong, nonatomic) IBOutlet UIButton *beaconSixButton;

- (IBAction)beaconOneTapped:(id)sender;
- (IBAction)beaconTwoTapped:(id)sender;

@end
