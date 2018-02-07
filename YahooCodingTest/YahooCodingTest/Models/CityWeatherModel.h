//
//  CityWeatherModel.h
//  YahooCodingTest
//
//  Created by admin on 2/5/18.
//  Copyright © 2018 ntdhat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Temperature : NSObject {
    float _baseTemperature; //kelvin
}

- (Temperature*)initWithKelvin:(float)k;
+ (Temperature*)temperatureInKelvin:(float)k;

@property (readonly) float kelvin;
@property (readonly) float celsius;
@property (readonly) float fahrenheit;

@end

@interface CurrentWeatherModel : NSObject

@property (nonatomic, readwrite) NSString* cityID;
@property (nonatomic, readwrite) NSString* cityName;
@property (nonatomic, readwrite) NSDate* date;
@property (nonatomic, readwrite) Temperature* temperature;
@property (nonatomic, readwrite) NSString* icon;

@end

@interface ForecastModel : NSObject

@property (nonatomic, readwrite) NSString* cityID;
@property (nonatomic, readwrite) NSString* cityName;
@property (nonatomic, readwrite) NSDate* date;
@property (nonatomic, readwrite) Temperature* temperatureMin;
@property (nonatomic, readwrite) Temperature* temperatureMax;
@property (nonatomic, readwrite) NSString* icon;

@end
