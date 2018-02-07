//
//  CustomCells.h
//  YahooCodingTest
//
//  Created by admin on 2/6/18.
//  Copyright © 2018 ntdhat. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WeatherViewModel;

@interface HomeScreenCustomTableviewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *weatherIcon;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;

- (void)configCellWithViewModel:(WeatherViewModel*)vmodel;

@end

@interface CurrentWeatherCell : HomeScreenCustomTableviewCell

@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureSymbolLabel;
@property (weak, nonatomic) IBOutlet UIButton *temperatureSwitchBtn;

+ (NSString*)NotificationSwitchTemperatureMode;

@end

@interface ForecastCell : HomeScreenCustomTableviewCell

@property (weak, nonatomic) IBOutlet UILabel *dayLabel;

@end
