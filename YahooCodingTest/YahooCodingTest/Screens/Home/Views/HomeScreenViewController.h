//
//  HomeScreenViewController.h
//  YahooCodingTest
//
//  Created by admin on 2/5/18.
//  Copyright © 2018 ntdhat. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "HomeScreenViewModel.h"
#include "FavoritesViewController.h"

@interface HomeScreenViewController : UIViewController <HomeScreenViewModelDelegate, FavoritesViewControllerProtocol, UITableViewDelegate, UITableViewDataSource> {
    HomeScreenViewModel* _viewModel;
}

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
