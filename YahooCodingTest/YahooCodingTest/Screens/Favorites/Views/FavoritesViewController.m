//
//  FavoritesViewController.m
//  YahooCodingTest
//
//  Created by admin on 2/6/18.
//  Copyright © 2018 ntdhat. All rights reserved.
//

#import "FavoritesViewController.h"
#include "FavoriteViewModel.h"

@interface FavoritesViewController ()

@end

@implementation FavoritesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _viewModel = [[FavoriteViewModel alloc] init];    
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
    if([segue.identifier isEqualToString:@"showAddLocationVC"]){
        AddLocationViewController *addLocVC = (AddLocationViewController*)segue.destinationViewController;
        addLocVC.delegate = self;
    }
}

#pragma mark - AddLocationViewControllerProtocol

- (void)didAddCity:(NSString *)cityName {
    NSArray* duplications = [_viewModel.cityNames filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF == %@", cityName]];
    
    if (duplications && duplications.count > 0) {
        // Display alertview for duplications
    } else {
        [_viewModel addNewCityIntoFavorites:cityName];
        [self.favoritesTableview reloadData];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _viewModel.cityNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FavoriteLocationCell" forIndexPath:indexPath];
    cell.textLabel.text = [_viewModel.cityNames objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* citySelected = [_viewModel.cityNames objectAtIndex:indexPath.row];
    if (self.delegate) {
        [self.delegate didSelectCity:citySelected];
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
