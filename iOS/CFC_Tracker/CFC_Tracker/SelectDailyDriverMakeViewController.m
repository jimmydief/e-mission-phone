//
//  SelectDailyDriverMakeViewController.m
//  E-Mission
//
//  Created by Jimmy Diefenderfer on 3/3/15.
//  Copyright (c) 2015 Kalyanaraman Shankari. All rights reserved.
//

#import "SelectDailyDriverMakeViewController.h"
#import "FuelEconomyParseOperation.h"

const NSString* API_BASE_URL = @"http://www.fueleconomy.gov/ws/rest/vehicle/menu/";

@implementation SelectDailyDriverMakeViewController : UITableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.makes = [[NSArray alloc] initWithObjects: @"Ford", @"Toyota", @"Honda", nil];
}

- (NSInteger) tableView: (UITableView*) tableView numberOfRowsInSection: (NSInteger) section
{
    return [self.makes count];
}

- (UITableViewCell*) tableView: (UITableView*) tableView cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];

    cell.textLabel.text = [self.makes objectAtIndex:indexPath.row];
    
    /* your other cell configurations
     cell.textLabel.text = ai.className; // eg. display name of text
     cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ | %@",ai.assignmentTitle,ai.dueDate]; // will show the cell with a detail text of "assignment title | due date" eg. "Lab 1 | 23 Oct 2013" appearing under the className called "Physics"
     */
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* make = [self.makes objectAtIndex:indexPath.row];
    NSArray* components = [[NSArray alloc] initWithObjects:@"model?year=", self.year, @"&make=", make, nil];
    NSString* path = [components componentsJoinedByString:@""];
    
    NSLog(path);
    
    NSURL* url = [NSURL URLWithString:[API_BASE_URL stringByAppendingString:path]];
    
    NSURLRequest* urlRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data) {
            [[FuelEconomyParseOperation alloc] initWithData:data];
        } else {
            NSLog(@"Error = %@", connectionError);
        }
    }];
}

//+ (void) setPickerFields: (NSInteger)columnChanged forYear:(NSString*)year forMake:(NSString*)make forModel:(NSString*)model forModelPicker:(UIPickerView*)modelPicker forOptionPicker:(UIPickerView*)optionPicker
//{
//    NSString* path;
//    NSArray* components;
//    switch (columnChanged) {
//            // model changed
//            components = [[NSArray alloc] initWithObjects:@"options?year=", year, @"&make=", make, @"&model=", model, nil];
//            path = [components componentsJoinedByString:@""];
//    }

@end
