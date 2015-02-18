//
//  SelectDailyDriverMPGController.m
//  E-Mission
//
//  Created by Jimmy Diefenderfer on 2/15/15.
//  Copyright (c) 2015 Kalyanaraman Shankari. All rights reserved.
//

#import "SelectDailyDriverMPGController.h"

const NSString* API_BASE_URL = @"http://www.fueleconomy.gov/ws/rest/vehicle/menu/";

@implementation SelectDailyDriverMPGController : UIViewController

// returns the number of 'columns' to display.
- (NSInteger) numberOfComponentsInPickerView: (UIPickerView *) pickerView
{
    return [pickerView isEqual: self.modelPicker] ? 3 : 1;
}

// returns the # of rows in each component..
- (NSInteger) pickerView: (UIPickerView *) pickerView numberOfRowsInComponent: (NSInteger) component
{
    if ([pickerView isEqual: self.modelPicker]) {
        switch (component) {
            case 0:
                return 6; // [self.years count];
            case 1:
                return 3; // [self.makes count];
            default:
                return 4; // [self.models count];
        }
    } else {
        return 2; // [self.options count]
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString* path = @"year";
    
    self.years = [[NSArray alloc] initWithObjects: @"1984", @"1985", @"1986", @"1987", @"1988", @"2012", nil];
    
    self.makes = [[NSArray alloc] initWithObjects: @"Ford", @"Toyota", @"Honda", nil];
    
    self.models = [[NSArray alloc] initWithObjects: @"Camry", @"Civic", @"Accord", @"Civic Hybrid", nil];
    
    self.options = [[NSArray alloc] initWithObjects: @"Dope", @"Meh", nil];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if ([pickerView isEqual: self.modelPicker]) {
        switch (component){
            case 0:
                return 65.0f;
            case 1:
                return 100.0f;
            default:
                return 160.0f;
        }
    } else {
        return 325.0f;
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if ([pickerView isEqual: self.modelPicker]) {
        switch (component) {
            case 0:
                return [self.years objectAtIndex:row];
            case 1:
                return [self.makes objectAtIndex:row];
            default:
                return [self.models objectAtIndex:row];
        }
    } else {
        return [self.options objectAtIndex:row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([pickerView isEqual: self.modelPicker]) {
        NSInteger yearRow = [self.modelPicker selectedRowInComponent:0];
        NSInteger makeRow = [self.modelPicker selectedRowInComponent:1];
        NSInteger modelRow = [self.modelPicker selectedRowInComponent:2];
        
        NSString* year = [self.years objectAtIndex:yearRow];
        NSString* make = [self.makes objectAtIndex:makeRow];
        NSString* model = [self.models objectAtIndex:modelRow];
        
        [SelectDailyDriverMPGController setPickerFields:component forYear:year forMake:make forModel:model];
    } else {
        // nothing
    }
}

+ (void) setPickerFields: (NSInteger)columnChanged forYear:(NSString*)year forMake:(NSString*)make forModel:(NSString*)model
{
    NSString* path;
    NSArray* components;
    switch (columnChanged) {
        case 0:
            // update make, model, and options
            path = [@"make?year=" stringByAppendingString:year];
            break;
        case 1:
            // update model and options
            components = [[NSArray alloc] initWithObjects:@"model?year=", year, @"&make=", make, nil];
            path = [components componentsJoinedByString:@""];
            break;
        default:
            // update options
            components = [[NSArray alloc] initWithObjects:@"options?year=", year, @"&make=", make, @"&model=", model, nil];
            path = [components componentsJoinedByString:@""];
            break;
    }
    
    NSString* urlString = [API_BASE_URL stringByAppendingString:path];
    NSURL* url = [NSURL URLWithString:urlString];
    NSDictionary* results = [SelectDailyDriverMPGController updateDataFromXML:url];
    
    NSLog (urlString);
    
    NSLog(@"%@", results);
    
    // [self.modelPicker reloadAllComponents];
    // [pickerView selectRow:0 inComponent:0 animated:YES];
}

+ (NSDictionary*) updateDataFromXML: (NSURL*)url
{
    NSDictionary* results = (NSDictionary*) [NSDictionary dictionaryWithContentsOfURL:url];
    return results;
}

@end
