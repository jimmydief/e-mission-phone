//
//  SelectDailyDriverOptionViewController.m
//  E-Mission
//
//  Created by Jimmy Diefenderfer on 3/3/15.
//  Copyright (c) 2015 Kalyanaraman Shankari. All rights reserved.
//

#import "SelectDailyDriverOptionViewController.h"
#import "FuelEconomyParseOperation.h"

@implementation SelectDailyDriverOptionViewController : UITableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.options = [[NSArray alloc] initWithObjects: @"4 doors", @"2 doors", nil];
}

@end
