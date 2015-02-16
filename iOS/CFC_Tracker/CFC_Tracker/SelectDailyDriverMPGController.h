//
//  SelectDailyDriverMPGController.h
//  E-Mission
//
//  Created by Jimmy Diefenderfer on 2/15/15.
//  Copyright (c) 2015 Kalyanaraman Shankari. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectDailyDriverMPGController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) IBOutlet UILabel *mpg;
@property (strong, nonatomic) IBOutlet UILabel *explanation;
@property (strong, nonatomic) IBOutlet UIButton *doneBtn;

@property (strong, nonatomic)          NSArray *years;
@property (strong, nonatomic)          NSArray *makes;
@property (strong, nonatomic)          NSArray *models;

@end
