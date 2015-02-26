//
//  FuelEconomyParseOperation.h
//  E-Mission
//
//  Created by Jimmy Diefenderfer on 2/24/15.
//  Copyright (c) 2015 Kalyanaraman Shankari. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FuelEconomyParseOperation : NSObject

@property (copy, readonly) NSData *fuelEconomyData;

- (id)initWithData:(NSData *)parseData;

@end
