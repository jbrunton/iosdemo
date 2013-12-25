//
//  MasterViewController.h
//  iosdemo
//
//  Created by John Brunton on 20/12/2013.
//  Copyright (c) 2013 John Brunton. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DataSource.h"

@class DetailViewController;

@interface TasksViewController : UIViewController

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (strong, nonatomic) DetailViewController *detailViewController;
@property (strong, nonatomic) DataSource* dataSource;

@end
