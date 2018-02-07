//
//  HomeScreenViewModel.m
//  YahooCodingTest
//
//  Created by admin on 2/5/18.
//  Copyright © 2018 ntdhat. All rights reserved.
//

#import "HomeScreenViewModel.h"
#import "OpenWeatherMapAccess.h"
#import "CityWeatherModel.h"
#import "FavoriteModel.h"
#import "DataManager.h"

@implementation WeatherViewModel
@end

@implementation HomeScreenViewModel

@synthesize forecasts = _forecastViewModels, currentWeather = _curWeatherViewModel, temperatureMode = _temperatureMode;

-(id) initWithDataAccess:(id)accessor delegate:(id)delegate {
    if (!(self = [super init])) {
        return nil;
    }
    
    if (accessor) {
        _dataAccess = accessor;
    } else {
        _dataAccess = [[OpenWeatherMapAccess alloc] init];
    }
    
    _delegate = delegate;
    _temperatureMode = Cel;
    self.currentDisplayedCity = [[[[DataManager shared] favoriteLocations] objectAtIndex:0] cityName];
    
    return self;
}

- (void)fetchWeatherAndForecastData {
    NSString *city = self.currentDisplayedCity;
    [self fetchCurrentWeatherDataForCity:city];
    [self fetchForecastDataForCity:city];
}

- (void)fetchCurrentWeatherDataForCity:(NSString*)city {
    OpenWeatherMapRequest *req = [OpenWeatherMapRequest requestByCity:city];
    [_dataAccess fetchCurrentWeatherDataByRequest:req completion:^(id model, NSError* error) {
        if (error) {
            if (_delegate) {
                [_delegate fetchWeathersError];
            }
            return;
        }
        _curWeatherModel = (CurrentWeatherModel*)model;
        
        WeatherViewModel *weatherVM = [[WeatherViewModel alloc] init];
        _curWeatherViewModel = weatherVM;
        
        // Name
        weatherVM.name = _curWeatherModel.cityName;
        
        // Temperature
        weatherVM.temperatureText = [NSString stringWithFormat:@"%d\u00B0",
                                     _temperatureMode == Cel ? (int)_curWeatherModel.temperature.celsius : (int)_curWeatherModel.temperature.fahrenheit];
        
        // Weather icon
        weatherVM.icon = [NSURL URLWithString:[NSString stringWithFormat:@"http://openweathermap.org/img/w/%@.png", _curWeatherModel.icon]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_delegate) {
                [_delegate cityCurrentWeatherFetched:model?YES:NO];
            }
        });
    }];
}

-(void) fetchForecastDataForCity:(NSString*) city {
    OpenWeatherMapRequest *req = [OpenWeatherMapRequest requestByCity:city];
    [_dataAccess fetchForecastDataByRequest:req completion:^(id models, NSError* error) {
        if (error) {
            if (_delegate) {
                [_delegate fetchWeathersError];
            }
            return;
        }
        _forecastModels = models;
        
        NSMutableArray *arrtemp = [NSMutableArray array];
        for (ForecastModel *forecast in models) {
            WeatherViewModel *weatherVM = [[WeatherViewModel alloc] init];
            [arrtemp addObject:weatherVM];
            
            // Name
            weatherVM.name = forecast.cityName;
            
            // Temperature
            weatherVM.temperatureText = [NSString stringWithFormat:@"%d\u00B0 - %d\u00B0 %@",
                                         _temperatureMode == Cel ? (int)forecast.temperatureMin.celsius : (int)forecast.temperatureMin.fahrenheit,
                                         _temperatureMode == Cel ? (int)forecast.temperatureMax.celsius : (int)forecast.temperatureMax.fahrenheit,
                                         _temperatureMode == Cel ? @"C" : @"F"];
            
            // Weather icon
            weatherVM.icon = [NSURL URLWithString:[NSString stringWithFormat:@"http://openweathermap.org/img/w/%@.png", forecast.icon]];
            
            // Day of forecast
            NSCalendar* cal = [NSCalendar currentCalendar];
            NSDateComponents* comp = [cal components:(NSCalendarUnitWeekday|NSCalendarUnitDay|NSCalendarUnitHour) fromDate:forecast.date];
            NSString *wkd;
            switch ([comp weekday]) {
                case 1:
                    wkd = @"Sunday";
                    break;
                case 2:
                    wkd = @"Monday";
                    break;
                case 3:
                    wkd = @"Tuesday";
                    break;
                case 4:
                    wkd = @"Wednesday";
                    break;
                case 5:
                    wkd = @"Thursday";
                    break;
                case 6:
                    wkd = @"Friday";
                    break;
                default:
                    wkd = @"Saturday";
                    break;
            }
            weatherVM.date = [NSString stringWithFormat:@"%@ %d", wkd, (int)[comp day]];
        }
        _forecastViewModels = arrtemp;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_delegate) {
                [_delegate cityForecastFetched:models?YES:NO];
            }
        });
    }];
}

- (UInt8)totalWeathersCount {
    return (UInt8)[_forecastViewModels count] + 1;
}

- (void)switchTemperatureMode {
    if (_temperatureMode == Cel) {
        _temperatureMode = Fah;
    } else {
        _temperatureMode = Cel;
    }
    
    _curWeatherViewModel.temperatureText = [NSString stringWithFormat:@"%d\u00B0", _temperatureMode == Cel ? (int)_curWeatherModel.temperature.celsius : (int)_curWeatherModel.temperature.fahrenheit];
    
    for (int i=0; i<_forecastViewModels.count; i++) {
        WeatherViewModel *wvm = [_forecastViewModels objectAtIndex:i];
        ForecastModel *fm = [_forecastModels objectAtIndex:i];
        // Temperature
        wvm.temperatureText = [NSString stringWithFormat:@"%d\u00B0 - %d\u00B0 %@",
                               _temperatureMode == Cel ? (int)fm.temperatureMin.celsius : (int)fm.temperatureMin.fahrenheit,
                               _temperatureMode == Cel ? (int)fm.temperatureMax.celsius : (int)fm.temperatureMax.fahrenheit,
                               _temperatureMode == Cel ? @"C" : @"F"];
    }
    
    if (_delegate) {
        [_delegate temperatureModeChanged];
    }
}

- (void)changeToCity:(NSString *)newCity {
    self.currentDisplayedCity = newCity;
}

@end


