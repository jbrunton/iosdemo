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

+ (NSArray*)parseResponse:(id)responseObject
{
    NSMutableArray* tasks = [[NSMutableArray alloc] init];
    
    for (NSDictionary* jsonTask in responseObject)
    {
        Task* task = [[Task alloc] initWithDictionary:jsonTask];
        [tasks addObject:task];
    }
    return tasks;
}

- (TaskGateway*)initWithRequestManager:(AFHTTPRequestOperationManager*)requestManager
{
    self = [self init];
    if (self) {
        self.requestManager = requestManager;
    }
    return self;
}

- (void)requestData:(id <GatewayResponseDelegate>)delegate
{
    id success = ^(AFHTTPRequestOperation *operation, id responseObject)
    {
        [delegate onResponseSuccessful:[TaskGateway parseResponse:responseObject]];
    };
    
    id failure =^(AFHTTPRequestOperation *operation, NSError *error)
    {
        [delegate onResponseFailure:error];
    };

    [self.requestManager GET:@"http://localhost:3000/tasks.json"
                  parameters:nil
                     success:success
                     failure:failure];
}

@end
