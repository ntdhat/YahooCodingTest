//
//  DataManager.m
//  YahooCodingTest
//
//  Created by admin on 2/6/18.
//  Copyright © 2018 ntdhat. All rights reserved.
//

#import "DataManager.h"
#include "FavoriteModel.h"

@implementation DataManager

static DataManager *sharedDataManager = nil;
+(DataManager*)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDataManager = [[self alloc] init];
    });
    return sharedDataManager;
}

- (id)init {
    if ((self = [super init])) {
        _storage = [NSUserDefaults standardUserDefaults];
        _favoriteLocations = [NSMutableArray array];
        return self;
    }
    return nil;
}

- (NSArray*)favoriteLocations {
    return _favoriteLocations;
}

- (void)addNewFavorite:(NSString *)newFav {
    FavoriteModel *md = [[FavoriteModel alloc] init];
    md.cityName = newFav;
    [_favoriteLocations addObject:md];
    
    [self save];
}

- (void)save {
    NSMutableArray *savedArr = [NSMutableArray array];
    for (FavoriteModel *md in _favoriteLocations) {
        [savedArr addObject:md.cityName];
    }
    [_storage setObject:savedArr forKey:@"favorites"];
}

- (void)load {
    [_favoriteLocations removeAllObjects];
    
    NSArray* rawFavDatas = [_storage objectForKey:@"favorites"];
    if (!rawFavDatas || rawFavDatas.count == 0) {
        FavoriteModel *md1 = [[FavoriteModel alloc] init];
        md1.cityName = @"Sunnyvale";
        [_favoriteLocations addObject:md1];
        
        FavoriteModel *md2 = [[FavoriteModel alloc] init];
        md2.cityName = @"San Francisco";
        [_favoriteLocations addObject:md2];
    } else {
        for (NSString* rawFavData in rawFavDatas) {
            FavoriteModel *md = [[FavoriteModel alloc] init];
            md.cityName = rawFavData;
            [_favoriteLocations addObject:md];
        }
    }
}

@end

