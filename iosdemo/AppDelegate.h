//
//  AppDelegate.h
//  iosdemo
//
//  Created by John Brunton on 20/12/2013.
//  Copyright (c) 2013 John Brunton. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TaskProvider.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) TaskProvider* taskProvider;

@end
