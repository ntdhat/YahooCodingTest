//
//  AddLocationViewController.m
//  YahooCodingTest
//
//  Created by admin on 2/7/18.
//  Copyright © 2018 ntdhat. All rights reserved.
//

#import "AddLocationViewController.h"
#include "AddLocationViewModel.h"

@interface AddLocationViewController ()

@end

@implementation AddLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _viewModel = [[AddLocationViewModel alloc] init];
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater = self;
    _searchController.dimsBackgroundDuringPresentation = YES;
    
    _searchController.searchBar.delegate = self;
    _searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    _searchController.searchBar.placeholder = @"Find location";
    [self.searchBarContainerView addSubview:_searchController.searchBar];
    
    self.definesPresentationContext = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = searchController.searchBar.text;
    if (searchString.length == 0) {
        [self.resultsTableview reloadData];
        return;
    }
    
    [_viewModel filterResultsWithText:searchString];
    
    [self.resultsTableview reloadData];
}

#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSString *text = searchBar.text;
    
    [_searchController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"Number of results: %d", (int)_viewModel.searchResults.count);
    return _viewModel.searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *cityDict = [_viewModel.searchResults objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LocationSearchResultCell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@, %@", [cityDict objectForKey:@"name"], [cityDict objectForKey:@"country"]];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *cityDict = [_viewModel.searchResults objectAtIndex:indexPath.row];
    NSString* citySelected = [cityDict objectForKey:@"name"];
    if (self.delegate) {
        [self.delegate didAddCity:citySelected];
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
