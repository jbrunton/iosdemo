//
//  DetailViewController.h
//  iosdemo
//
//  Created by John Brunton on 20/12/2013.
//  Copyright (c) 2013 John Brunton. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Task.h"

@interface TaskDetailViewController : UIViewController

@property (strong, nonatomic) Task* task;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

- (void)configureView;

@end
