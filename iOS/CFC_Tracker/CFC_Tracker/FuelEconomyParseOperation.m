//
//  FuelEconomyParseOperation.m
//  E-Mission
//
//  Created by Jimmy Diefenderfer on 2/24/15.
//  Copyright (c) 2015 Kalyanaraman Shankari. All rights reserved.
//

#import "FuelEconomyParseOperation.h"

@interface FuelEconomyParseOperation () <NSXMLParserDelegate>

@property (nonatomic) NSMutableArray *currentValueEntries;
@property (nonatomic) NSMutableArray *currentTextEntries;
@property (nonatomic) NSMutableArray *currentParseBatch;
@property (nonatomic) NSMutableString *currentParsedCharacterData;

@end

@implementation FuelEconomyParseOperation
{
    BOOL _accumulatingParsedCharacterData;
    NSUInteger _parsedCounter;
}

- (id)initWithData:(NSData *)parseData {
    
    self = [super init];
    if (self) {
        _fuelEconomyData = [parseData copy];
        _currentParsedCharacterData = [[NSMutableString alloc] init];
        
        NSXMLParser *parser = [[NSXMLParser alloc] initWithData:self.fuelEconomyData];
        [parser setDelegate:self];
        [parser parse];
    }
    
    return self;
}

- (void)addVehiclesToList:(NSArray *)vehicles {
//    something with vehicles arrays
}

#pragma mark - Parser constants

// Reduce potential parsing errors by using string constants declared in a single place.
static NSString * const menuItemsElementName = @"menuItems";
static NSString * const menuItemElementName = @"menuItem";
static NSString * const textElementName = @"text";
static NSString * const valueElementName = @"value";

#pragma mark - NSXMLParser delegate methods

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    if ([elementName isEqualToString:menuItemsElementName]) {
        _currentTextEntries = [[NSMutableArray alloc] init];
        _currentValueEntries = [[NSMutableArray alloc] init];
    } else if ([elementName isEqualToString:textElementName] || [elementName isEqualToString:valueElementName]) {
        // For the 'text' and 'value' elements begin accumulating parsed character data.
        // The contents are collected in parser:foundCharacters:.
        _accumulatingParsedCharacterData = YES;
        // The mutable string needs to be reset to empty.
        [self.currentParsedCharacterData setString:@""];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:menuItemsElementName]) {
        // do something
    } else if ([elementName isEqualToString:textElementName]) {
        NSString* text = [NSString stringWithString: self.currentParsedCharacterData];
        [_currentTextEntries addObject:text];
    } else if ([elementName isEqualToString:valueElementName]) {
        NSString* value = [NSString stringWithString: self.currentParsedCharacterData];
        [_currentValueEntries addObject:value];
    }
    
    // Stop accumulating parsed character data. We won't start again until specific elements begin.
    _accumulatingParsedCharacterData = NO;
}

/**
 This method is called by the parser when it find parsed character data ("PCDATA") in an element. The parser is not guaranteed to deliver all of the parsed character data for an element in a single invocation, so it is necessary to accumulate character data until the end of the element is reached.
 */
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if (_accumulatingParsedCharacterData) {
        // If the current element is one whose content we care about, append 'string'
        // to the property that holds the content of the current element.
        [self.currentParsedCharacterData appendString:string];
    }
}

/**
 An error occurred while parsing the earthquake data: post the error as an NSNotification to our app delegate.
 */
- (void)handleVehiclesError:(NSError *)parseError {
    
    assert([NSThread isMainThread]);
    NSLog(parseError);
}

/**
 An error occurred while parsing the earthquake data, pass the error to the main thread for handling.
 (Note: don't report an error if we aborted the parse due to a max limit of earthquakes.)
 */
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    
    if ([parseError code] != NSXMLParserDelegateAbortedParseError) {
        [self performSelectorOnMainThread:@selector(handleVehiclesError:) withObject:parseError waitUntilDone:NO];
    }
}

@end
