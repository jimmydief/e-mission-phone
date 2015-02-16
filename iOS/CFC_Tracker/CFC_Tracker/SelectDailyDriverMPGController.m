//
//  SelectDailyDriverMPGController.m
//  E-Mission
//
//  Created by Jimmy Diefenderfer on 2/15/15.
//  Copyright (c) 2015 Kalyanaraman Shankari. All rights reserved.
//

#import "SelectDailyDriverMPGController.h"

const NSString* FUEL_ECONOMY_API_BASE_URL = @"http://www.fueleconomy.gov/ws/rest/vehicle/menu";

@implementation SelectDailyDriverMPGController : UIViewController

// returns the number of 'columns' to display.
- (NSInteger) numberOfComponentsInPickerView: (UIPickerView *) pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger) pickerView: (UIPickerView *) pickerView numberOfRowsInComponent: (NSInteger) component
{
    return 6;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.years = [[NSArray alloc] initWithObjects: @"1984", @"1985", @"1986", @"1987", @"1988", @"1989", nil];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.years objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.mpg.text = [self.years objectAtIndex:row];
}

@end
