//
//  TimeHelper.m
//  iosdemo
//
//  Created by John Brunton on 20/12/2013.
//  Copyright (c) 2013 John Brunton. All rights reserved.
//

#import "TimeHelper.h"

@implementation TimeHelper

- (NSString*)prettyFormat:(NSDate*)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM d y"];
    
    return [dateFormatter stringFromDate:date];
}

@end
