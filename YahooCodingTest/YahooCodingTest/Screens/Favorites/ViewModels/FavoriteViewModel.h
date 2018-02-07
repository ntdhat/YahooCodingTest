//
//  FavoriteViewModel.h
//  YahooCodingTest
//
//  Created by admin on 2/6/18.
//  Copyright © 2018 ntdhat. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DataManager;

@interface FavoriteViewModel : NSObject {
    DataManager* _dataManager;
    
    NSMutableArray* _cityNames;
}

@property (nonatomic, readonly) NSArray* cityNames;

- (void)addNewCityIntoFavorites:(NSString*)cityName;

@end
