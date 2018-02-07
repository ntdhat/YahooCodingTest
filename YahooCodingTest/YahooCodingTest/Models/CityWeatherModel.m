//
//  CityWeatherModel.m
//  YahooCodingTest
//
//  Created by admin on 2/5/18.
//  Copyright © 2018 ntdhat. All rights reserved.
//

#import "CityWeatherModel.h"

@implementation Temperature

+ (Temperature*)temperatureInKelvin:(float)k {
    Temperature *temperature = [[Temperature alloc] initWithKelvin:k];
    return temperature;
}

- (Temperature*)initWithKelvin:(float)k {
    if (!(self = [super init])) {
        return nil;
    }
    _baseTemperature = k;
    return self;
}

- (float)kelvin {
    return _baseTemperature;
}

- (float)celsius {
    return _baseTemperature - 273.15f;
}

- (float)fahrenheit {
    return 1.8f * (_baseTemperature - 273) + 32;
}

@end

@implementation CurrentWeatherModel

@end

@implementation ForecastModel

@end
