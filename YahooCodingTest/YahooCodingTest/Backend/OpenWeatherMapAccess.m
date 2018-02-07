//
//  OpenWeatherMapAccess.m
//  YahooCodingTest
//
//  Created by admin on 2/5/18.
//  Copyright © 2018 ntdhat. All rights reserved.
//

#import "OpenWeatherMapAccess.h"
#include "CityWeatherModel.h"

@implementation OpenWeatherMapRequest

@synthesize cityName = _cityName;

+(OpenWeatherMapRequest*) requestByCity:(NSString *)cityName {
    OpenWeatherMapRequest *req = [[OpenWeatherMapRequest alloc] init];
    req.cityName = cityName;
    return req;
}

@end

@implementation OpenWeatherMapAccess

static NSString *const kOpenWeatherMap_CurrentWeatherURL = @"http://api.openweathermap.org/data/2.5/weather?q=";
static NSString *const kOpenWeatherMap_ForecastURL = @"http://api.openweathermap.org/data/2.5/forecast/daily?q=";
static NSString *const kOpenWeatherMap_AppID = @"adb4503a31093fed77c0a5f39d4c512b";

- (id)init {
    if ((self = [super init])) {
        return self;
    }
    return nil;
}

- (void)fetchCurrentWeatherDataByRequest:(OpenWeatherMapRequest *)req completion:(OpenWeatherMapRequestCompletion)completion {
    // Create the request.
    NSMutableString* urlString = [NSMutableString stringWithString:kOpenWeatherMap_CurrentWeatherURL];
    [urlString appendFormat:@"%@", req.cityName];
    [urlString appendFormat:@"&appid=%@", kOpenWeatherMap_AppID];
    NSURL* url = [NSURL URLWithString:[urlString stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet]];
    
    // Send Request
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completion(NULL, error);
            return;
        }
        
        NSError* jsonError;
        NSDictionary *dictData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
        if (jsonError) {
            completion(NULL, error);
            return;
        }
        
        CurrentWeatherModel *curWeatherModel = [[CurrentWeatherModel alloc] init];
        curWeatherModel.cityID = [dictData objectForKey:@"id"];
        curWeatherModel.cityName = [dictData objectForKey:@"name"];
        curWeatherModel.temperature = [Temperature temperatureInKelvin:[[[dictData objectForKey:@"main"] objectForKey:@"temp"] floatValue]];
        curWeatherModel.icon = [[[dictData objectForKey:@"weather"] objectAtIndex:0] objectForKey:@"icon"];
        curWeatherModel.date = [NSDate dateWithTimeIntervalSince1970:[[dictData objectForKey:@"dt"] doubleValue]];
        
        completion(curWeatherModel, NULL);
    }];
    
    [task resume];
}

-(void) fetchForecastDataByRequest:(OpenWeatherMapRequest *)req completion:(OpenWeatherMapRequestCompletion)completion {
    // Create the request.
    NSMutableString* urlString = [NSMutableString stringWithString:kOpenWeatherMap_ForecastURL];
    [urlString appendFormat:@"%@", req.cityName];
    [urlString appendString:@"&cnt=16"];
    [urlString appendFormat:@"&appid=%@", kOpenWeatherMap_AppID];
    NSURL* url = [NSURL URLWithString:[urlString stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet]];
    
    // Send Request
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completion(NULL, error);
            return;
        }
        
        NSError* jsonError;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
        
        if (jsonError) {
            completion(NULL, error);
            return;
        }
        
        NSDictionary *city = [dict objectForKey:@"city"];
        NSArray *forecasts = [dict objectForKey:@"list"];
        
        NSMutableArray *forecastModels = [NSMutableArray array];
        
        for (NSDictionary* forecast in forecasts) {
            ForecastModel *forecastModel = [[ForecastModel alloc] init];
            forecastModel.cityID = [city objectForKey:@"id"];
            forecastModel.cityName = [city objectForKey:@"name"];
            forecastModel.temperatureMin = [Temperature temperatureInKelvin:[[[forecast objectForKey:@"temp"] objectForKey:@"min"] floatValue]];
            forecastModel.temperatureMax = [Temperature temperatureInKelvin:[[[forecast objectForKey:@"temp"] objectForKey:@"max"] floatValue]];;
            forecastModel.icon = [[[forecast objectForKey:@"weather"] objectAtIndex:0] objectForKey:@"icon"];
            forecastModel.date = [NSDate dateWithTimeIntervalSince1970:[[forecast objectForKey:@"dt"] doubleValue]];
            
            [forecastModels addObject:forecastModel];
        }
        
        completion(forecastModels, NULL);
    }];
    
    [task resume];
}

@end


