//
//  SelectDailyDriverModelViewController.m
//  E-Mission
//
//  Created by Jimmy Diefenderfer on 3/3/15.
//  Copyright (c) 2015 Kalyanaraman Shankari. All rights reserved.
//

#import "SelectDailyDriverModelViewController.h"
#import "FuelEconomyParseOperation.h"

const NSString* API_BASE_URL = @"http://www.fueleconomy.gov/ws/rest/vehicle/menu/";

@implementation SelectDailyDriverModelViewController : UITableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.models = [[NSArray alloc] initWithObjects: @"Camry", @"Civic", @"Accord", @"Civic Hybrid", nil];
}

@end