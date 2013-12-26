//
//  UIStoryboard+HelperMethods.m
//  iosdemo
//
//  Created by John Brunton on 26/12/2013.
//  Copyright (c) 2013 John Brunton. All rights reserved.
//

#import "HelperMethods.h"

@implementation UIStoryboard (HelperMethods)

+ (UIViewController *)instantiateAndLoad:(NSString *)identifier
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    UIViewController* controller = [storyboard instantiateViewControllerWithIdentifier:identifier];
    [controller performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];
    return controller;
}


@end
