//
//  FavoritesViewController.h
//  YahooCodingTest
//
//  Created by admin on 2/6/18.
//  Copyright © 2018 ntdhat. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "AddLocationViewController.h"
@class FavoriteViewModel;

@protocol FavoritesViewControllerProtocol
- (void)didSelectCity:(NSString*)cityName;
@end

@interface FavoritesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, AddLocationViewControllerProtocol> {
    FavoriteViewModel* _viewModel;
}
@property (nonatomic, weak) id<FavoritesViewControllerProtocol> delegate;

@property (weak, nonatomic) IBOutlet UITableView *favoritesTableview;

@end
