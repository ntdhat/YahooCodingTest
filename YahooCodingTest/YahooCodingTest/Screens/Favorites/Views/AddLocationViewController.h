//
//  AddLocationViewController.h
//  YahooCodingTest
//
//  Created by admin on 2/7/18.
//  Copyright © 2018 ntdhat. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddLocationViewModel;

@protocol AddLocationViewControllerProtocol
- (void)didAddCity:(NSString*)cityName;
@end

@interface AddLocationViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchResultsUpdating> {
    AddLocationViewModel *_viewModel;
    
    UISearchController* _searchController;
}
@property (nonatomic, weak) id<AddLocationViewControllerProtocol> delegate;

@property (weak, nonatomic) IBOutlet UIView *searchBarContainerView;
@property (weak, nonatomic) IBOutlet UITableView *resultsTableview;

@end
