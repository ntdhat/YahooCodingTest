//
//  HomeScreenViewController.m
//  YahooCodingTest
//
//  Created by admin on 2/5/18.
//  Copyright © 2018 ntdhat. All rights reserved.
//

#import "HomeScreenViewController.h"
#include "CustomCells.h"

@interface HomeScreenViewController ()

@end

@implementation HomeScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _viewModel = [[HomeScreenViewModel alloc] initWithDataAccess:nil delegate:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:_viewModel selector:@selector(switchTemperatureMode) name:CurrentWeatherCell.NotificationSwitchTemperatureMode object:NULL];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [_viewModel fetchWeatherAndForecastData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"showFavoritesScreen"]){
        FavoritesViewController *favVC = (FavoritesViewController*)segue.destinationViewController;
        favVC.delegate = self;
    }
}

#pragma mark - HomeScreenViewModelDelegate
- (void)didSelectCity:(NSString *)cityName {
    NSLog(@"City selected: %@", cityName);
    [_viewModel changeToCity:cityName];
}

#pragma mark - HomeScreenViewModelDelegate
- (void)cityForecastFetched:(BOOL)success {
    if (success) {
        [self.tableview setHidden:NO];
        [self.tableview reloadData];
    }
}

- (void)cityCurrentWeatherFetched:(BOOL)success {
    if (success) {
        [self.activityIndicator stopAnimating];
        [self.tableview setHidden:NO];
        [self.tableview reloadData];
    }
}

- (void)fetchWeathersError {
    NSLog(@"Fetch weather data error!");
}

- (void)temperatureModeChanged {
    [self.tableview reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _viewModel.totalWeathersCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeatherViewModel *cellViewModel;
    HomeScreenCustomTableviewCell *cell;
    if (indexPath.row > 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"ForecastCell" forIndexPath:indexPath];
        cellViewModel = [_viewModel.forecasts objectAtIndex:indexPath.row - 1];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"CurrentWeatherCell" forIndexPath:indexPath];
        cellViewModel = _viewModel.currentWeather;
    }
    [cell configCellWithViewModel:cellViewModel];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row > 0) {
        return 50;
    } else {
        return 128;
    }
}

@end
