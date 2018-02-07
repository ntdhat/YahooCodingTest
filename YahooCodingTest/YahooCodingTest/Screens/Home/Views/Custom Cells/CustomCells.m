//
//  CustomCells.m
//  YahooCodingTest
//
//  Created by admin on 2/6/18.
//  Copyright © 2018 ntdhat. All rights reserved.
//

#import "CustomCells.h"
#import "HomeScreenViewModel.h"

@implementation HomeScreenCustomTableviewCell
- (void)configCellWithViewModel:(WeatherViewModel *)vmodel {
    self.temperatureLabel.text = vmodel.temperatureText;
//    self.weatherIcon.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:vmodel.icon]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:vmodel.icon];

        //set your image on main thread.
        dispatch_async(dispatch_get_main_queue(), ^{
            self.weatherIcon.image = [UIImage imageWithData:data];
        });
    });
}
@end

@implementation CurrentWeatherCell
- (void)configCellWithViewModel:(WeatherViewModel *)vmodel {
    [super configCellWithViewModel:vmodel];
    self.cityNameLabel.text = vmodel.name;
}
- (IBAction)switchTemperatureMode:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:CurrentWeatherCell.NotificationSwitchTemperatureMode object:NULL];
    
    if ([self.temperatureSwitchBtn.titleLabel.text isEqualToString:@"C"]) {
        [self.temperatureSwitchBtn setTitle:@"F" forState:UIControlStateNormal];
        self.temperatureSymbolLabel.text = @"C";
    } else {
        [self.temperatureSwitchBtn setTitle:@"C" forState:UIControlStateNormal];
        self.temperatureSymbolLabel.text = @"F";
    }
}

+(NSString*)NotificationSwitchTemperatureMode {
    return @"switch_temperature_mode";
}
@end

@implementation ForecastCell
- (void)configCellWithViewModel:(WeatherViewModel *)vmodel {
    [super configCellWithViewModel:vmodel];
    self.dayLabel.text = vmodel.date;
}
@end
