//
//  DataManager.h
//  YahooCodingTest
//
//  Created by admin on 2/6/18.
//  Copyright © 2018 ntdhat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject {
    NSUserDefaults* _storage;
    NSMutableArray* _favorites;
}

@property (nonatomic, readonly) NSArray* favorites;

+(DataManager*)shared;

- (void)addNewFavorite:(NSString*)newFav;

- (void)save;
- (void)load;

@end
