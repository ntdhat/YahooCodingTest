//
//  FavoriteViewModel.m
//  YahooCodingTest
//
//  Created by admin on 2/6/18.
//  Copyright © 2018 ntdhat. All rights reserved.
//

#import "FavoriteViewModel.h"
#include "FavoriteModel.h"
#include "DataManager.h"

@implementation FavoriteViewModel

- (id)init {
    if ((self = [super init])) {
        _dataManager = [DataManager shared];
        
        _cityNames = [NSMutableArray array];
        for (FavoriteModel* fm in _dataManager.favoriteLocations) {
            [_cityNames addObject:fm.cityName];
        }
        
        return self;
    }
    return nil;
}

- (void)addNewCityIntoFavorites:(NSString *)cityName {
    [_cityNames addObject:cityName];
    [_dataManager addNewFavorite:cityName];
}

- (NSArray*)cityNames {
    return (NSArray*)_cityNames;
}

@end

