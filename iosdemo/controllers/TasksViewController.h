//
//  MasterViewController.h
//  iosdemo
//
//  Created by John Brunton on 20/12/2013.
//  Copyright (c) 2013 John Brunton. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DataSource.h"

@class TaskDetailViewController;

@interface TasksViewController : UIViewController

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, weak) NSNotificationCenter* notificationCenter;

@property (strong, nonatomic) TaskDetailViewController *detailViewController;
@property (strong, nonatomic) DataSource* dataSource;

- (void)registerWith:(NSNotificationCenter*)notifcationCenter;

@end
