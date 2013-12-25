//
//  MasterViewController.m
//  iosdemo
//
//  Created by John Brunton on 20/12/2013.
//  Copyright (c) 2013 John Brunton. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"
#import "Task.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController

//- (id)init
//{
//    self = [super init];
//    if (self) {
//        _objects = [[NSMutableArray alloc] init];
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonClicked:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    if (_objects == nil) {
        _objects = [[NSMutableArray alloc] init];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onTasksAvailable:)
                                                 name:@"TasksAvailable"
                                               object:nil];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"TasksRequest" object:nil];
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
    [_objects removeAllObjects];
    [_objects addObjectsFromArray:tasks];
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

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDate *object = _objects[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        NSDate *object = _objects[indexPath.row];
        self.detailViewController.detailItem = object;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
