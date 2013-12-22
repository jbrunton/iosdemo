//
//  TaskGateway.m
//  iosdemo
//
//  Created by John Brunton on 21/12/2013.
//  Copyright (c) 2013 John Brunton. All rights reserved.
//

#import "TaskGateway.h"

#import "Task.h"
#import <AFNetworking.h>

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

- (void)requestData:(id <GatewayResponseDelegate>)delegate
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://localhost:3000/tasks.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [delegate onResponseSuccessful:[TaskGateway parseResponse:responseObject]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//        NSMutableArray* data = [NSMutableArray arrayWithObject:[[Task alloc] initWithId:1 andDescription:@"Some Task" andDueDate:nil]];
//        [delegate onResponseSuccessful:data];
//    });
}

@end
