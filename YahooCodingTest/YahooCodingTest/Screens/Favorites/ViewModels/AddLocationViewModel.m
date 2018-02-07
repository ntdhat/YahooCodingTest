//
//  AddLocationViewModel.m
//  YahooCodingTest
//
//  Created by admin on 2/7/18.
//  Copyright © 2018 ntdhat. All rights reserved.
//

#import "AddLocationViewModel.h"

@implementation AddLocationViewModel

@synthesize searchResults = _searchResults;

- (id)init {
    if ((self = [super init])) {
        [self loadCitiesData];
        
        return self;
    }
    return nil;
}

- (void)loadCitiesData {
    NSString* pathToCitiesData = [[NSBundle mainBundle] pathForResource:@"city.list" ofType:@"json"];
    NSData *citiesRawData = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:pathToCitiesData] options:NSDataReadingMappedAlways error:NULL];
    _citiesData = [NSJSONSerialization JSONObjectWithData:citiesRawData options:NSJSONReadingMutableContainers error:NULL];
}

- (void)filterResultsWithText:(NSString*)filterText {
    NSPredicate* predict = [NSPredicate predicateWithFormat:@"SELF['name'] BEGINSWITH[cd] %@", filterText];
    _searchResults = [_citiesData filteredArrayUsingPredicate:predict];
}

@end
