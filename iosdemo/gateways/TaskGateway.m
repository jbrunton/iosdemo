//
//  TaskGateway.m
//  iosdemo
//
//  Created by John Brunton on 21/12/2013.
//  Copyright (c) 2013 John Brunton. All rights reserved.
//

#import "TaskGateway.h"

#import "Task.h"

@implementation TaskGateway

- (void)requestData:(id <GatewayResponseDelegate>)delegate
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        NSMutableArray* data = [NSMutableArray arrayWithObject:[[Task alloc] initWithId:1 andDescription:@"Some Task" andDueDate:nil]];
        [delegate onResponseSuccessful:data];
    });
}

@end
