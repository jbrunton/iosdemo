//
//  DetailViewController.h
//  iosdemo
//
//  Created by John Brunton on 20/12/2013.
//  Copyright (c) 2013 John Brunton. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
