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
    return 3;
}

// returns the # of rows in each component..
- (NSInteger) pickerView: (UIPickerView *) pickerView numberOfRowsInComponent: (NSInteger) component
{
    switch (component) {
        case 0:
            return 6; // [self.years count];
        case 1:
            return 3; // [self.makes count];
        default:
            return 4; // [self.models count];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.years = [[NSArray alloc] initWithObjects: @"1984", @"1985", @"1986", @"1987", @"1988", @"1989", nil];
    
    self.makes = [[NSArray alloc] initWithObjects: @"Ford", @"Toyota", @"Honda", nil];
    
    self.models = [[NSArray alloc] initWithObjects: @"Camry", @"Civic", @"Accord", @"Civic Hybrid", nil];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    switch (component){
        case 0:
            return 65.0f;
        case 1:
            return 100.0f;
        default:
            return 160.0f;
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [self.years objectAtIndex:row];
        case 1:
            return [self.makes objectAtIndex:row];
        default:
            return [self.models objectAtIndex:row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSInteger yearRow = [self.pickerView selectedRowInComponent:0];
    NSInteger makeRow = [self.pickerView selectedRowInComponent:1];
    NSInteger modelRow = [self.pickerView selectedRowInComponent:2];
    
    NSString* year = [self.years objectAtIndex:yearRow];
    NSString* make = [self.makes objectAtIndex:makeRow];
    NSString* model = [self.models objectAtIndex:modelRow];
    
    NSArray *components = [[NSArray alloc] initWithObjects:year, make, model, nil];
    NSString *vehicle = [components componentsJoinedByString:@" "];
    
    self.mpg.text = vehicle;
}

@end
