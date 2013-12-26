//
//  DetailViewController.m
//  iosdemo
//
//  Created by John Brunton on 20/12/2013.
//  Copyright (c) 2013 John Brunton. All rights reserved.
//

#import "TaskDetailViewController.h"

@interface TaskDetailViewController ()
- (void)configureView;
@end

@implementation TaskDetailViewController

#pragma mark - Managing the detail item

- (void)setTask:(id)task
{
    if (_task != task) {
        _task = task;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the task

    if (self.task) {
        self.detailDescriptionLabel.text = [self.task description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
