//
//  MasterViewController.m
//  iosdemo
//
//  Created by John Brunton on 20/12/2013.
//  Copyright (c) 2013 John Brunton. All rights reserved.
//

#import "TasksViewController.h"

#import "TaskDetailViewController.h"
#import "Task.h"

@implementation TasksViewController

- (void)registerWith:(NSNotificationCenter*)notifcationCenter
{
    self.notificationCenter = notifcationCenter;

    [notifcationCenter addObserver:self
                         selector:@selector(onTasksAvailable:)
                             name:@"TasksAvailable"
                           object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonClicked:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    self.tableView.delegate = self.dataSource;
    self.tableView.dataSource = self.dataSource;
    
    [self.notificationCenter postNotificationName:@"TasksRequest" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)onAddTask:(NSNotification*)notification
//{
//    Task* task = [[notification userInfo] objectForKey:@"task"];
//
//    [_objects insertObject:task atIndex:0];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//}

- (void)onTasksAvailable:(NSNotification*)notification
{
    NSArray* tasks = [[notification userInfo] objectForKey:@"data"];
    [self.dataSource setData:tasks];
    [self.tableView reloadData];
}

- (void)addButtonClicked:(id)sender
{
//    Task* task = [[Task alloc] initWithId:1
//                           andDescription:@"Foo"
//                               andDueDate:[NSDate date]];
//    NSDictionary* userInfo = [NSDictionary dictionaryWithObject:task
//                                                        forKey:@"task"];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"AddTask"
//                                                        object:nil
//                                                      userInfo:userInfo];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Task* task = (Task*)self.dataSource.getData[indexPath.row];
        [[segue destinationViewController] setTask:task];
    }
}

@end
