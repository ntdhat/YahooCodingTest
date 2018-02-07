//
//  HomeScreenViewModel.h
//  YahooCodingTest
//
//  Created by admin on 2/5/18.
//  Copyright © 2018 ntdhat. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CurrentWeatherModel, OpenWeatherMapAccess, Temperature;

typedef enum : NSUInteger {
    Cel,
    Fah
} TemperatureMode;

@protocol HomeScreenViewModelDelegate
- (void)cityCurrentWeatherFetched:(BOOL)success;
- (void)cityForecastFetched:(BOOL)success;
- (void)fetchWeathersError;
- (void)temperatureModeChanged;
@end

@interface WeatherViewModel : NSObject

@property (nonatomic, readwrite) NSString* temperatureText;
@property (nonatomic, readwrite) NSString* name;
@property (nonatomic, readwrite) NSString* date;
@property (nonatomic, readwrite) NSURL* icon;

@end

@interface HomeScreenViewModel : NSObject {
    id _dataAccess;
    id _delegate;
    
    CurrentWeatherModel* _curWeatherModel;
    WeatherViewModel* _curWeatherViewModel;
    
    NSArray *_forecastModels;
    NSArray *_forecastViewModels;
}

@property (nonatomic, readonly) WeatherViewModel* currentWeather;
@property (nonatomic, readonly) NSArray* forecasts;
@property (readonly) UInt8 totalWeathersCount;
@property (readonly) TemperatureMode temperatureMode;
@property (nonatomic, strong) NSString* currentDisplayedCity;

- (id)initWithDataAccess:(OpenWeatherMapAccess*)accessor delegate:(id)delegate;

- (void)fetchWeatherAndForecastData;
- (void)switchTemperatureMode;
- (void)changeToCity:(NSString*)newCity;

@end
