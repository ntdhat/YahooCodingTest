//
//  OpenWeatherMapAccess.h
//  YahooCodingTest
//
//  Created by admin on 2/5/18.
//  Copyright © 2018 ntdhat. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CityWeatherModel;

@interface OpenWeatherMapRequest: NSObject {
    NSString* _cityName;
}
@property (nonatomic, strong) NSString* cityName;
+(OpenWeatherMapRequest*) requestByCity:(NSString*) cityName;
@end

typedef void(^OpenWeatherMapRequestCompletion)(id model);

@interface OpenWeatherMapAccess : NSObject {
    NSMutableData *_responseData;
}
- (id)init;

- (void)fetchCurrentWeatherDataByRequest:(OpenWeatherMapRequest*) req completion:(OpenWeatherMapRequestCompletion) completion;
- (void)fetchForecastDataByRequest:(OpenWeatherMapRequest*) req completion:(OpenWeatherMapRequestCompletion) completion;
@end
