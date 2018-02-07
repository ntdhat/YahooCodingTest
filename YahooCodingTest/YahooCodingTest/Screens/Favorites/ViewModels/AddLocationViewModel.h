//
//  AddLocationViewModel.h
//  YahooCodingTest
//
//  Created by admin on 2/7/18.
//  Copyright © 2018 ntdhat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddLocationViewModel : NSObject {
    NSArray* _citiesData;
    NSArray* _searchResults;
}

@property (nonatomic, readonly) NSArray* searchResults;

- (void)filterResultsWithText:(NSString*)filterText;

@end
