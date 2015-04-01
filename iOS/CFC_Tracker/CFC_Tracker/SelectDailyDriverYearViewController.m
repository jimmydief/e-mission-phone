//
//  SelectDailyDriverYearViewController.m
//  E-Mission
//
//  Created by Jimmy Diefenderfer on 2/15/15.
//  Copyright (c) 2015 Kalyanaraman Shankari. All rights reserved.
//

#import "SelectDailyDriverYearViewController.h"
#import "FuelEconomyParseOperation.h"

const NSString* API_BASE_URL = @"http://www.fueleconomy.gov/ws/rest/vehicle/menu/";

@implementation SelectDailyDriverYearViewController : UITableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.years = [[NSArray alloc] initWithObjects: @"1984", @"1985", @"1986", @"1987", @"1988", @"2012", nil];
}

- (NSInteger) tableView: (UITableView*) tableView numberOfRowsInSection: (NSInteger) section
{
    return [self.years count];
}

- (UITableViewCell*) tableView: (UITableView*) tableView cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    cell.textLabel.text = [self.years objectAtIndex:indexPath.row];
    
    return cell;
    
    /* your other cell configurations
     cell.textLabel.text = ai.className; // eg. display name of text
     cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ | %@",ai.assignmentTitle,ai.dueDate]; // will show the cell with a detail text of "assignment title | due date" eg. "Lab 1 | 23 Oct 2013" appearing under the className called "Physics"
     */
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* year = [self.years objectAtIndex:indexPath.row];
    NSString* path = [@"make?year=" stringByAppendingString:year];
    
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

@end
