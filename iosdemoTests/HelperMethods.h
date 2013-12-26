//
//  UIStoryboard+HelperMethods.h
//  iosdemo
//
//  Created by John Brunton on 26/12/2013.
//  Copyright (c) 2013 John Brunton. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIStoryboard (HelperMethods)

+ (UIViewController*)instantiateAndLoad:(NSString*)identifier;

@end
