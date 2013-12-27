//
//  TaskProvider.m
//  iosdemo
//
//  Created by John Brunton on 21/12/2013.
//  Copyright (c) 2013 John Brunton. All rights reserved.
//

#import "TaskProvider.h"

@implementation TaskProvider

- (void)registerWith:(NSNotificationCenter*)notificationCenter
{
    self.notificationCenter = notificationCenter;
    [notificationCenter addObserver:self
                           selector:@selector(onTasksRequest:)
                               name:@"TasksRequest"
                             object:nil];
}

- (void)onTasksRequest:(NSNotification*)notification
{
    NSDictionary* userInfo = [notification userInfo];
    NSNumber* refresh = [userInfo objectForKey:@"refresh"];
    if (!self.tasks || (refresh && [refresh boolValue])) {
        [self.gateway requestData:self];
    } else {
        [self postData];
    }
}

- (void)postData
{
    NSDictionary* userInfo = [NSDictionary dictionaryWithObject:self.tasks forKey:@"data"];
    [self.notificationCenter postNotificationName:@"TasksAvailable"
                                           object:nil
                                         userInfo:userInfo];
}

- (TaskProvider*)initWithGateway:(TaskGateway*)gateway
{
    self = [self init];
    if (self) {
        self.gateway = gateway;
    }
    return self;
}

- (void)addTask:(Task *)task
{
    [self.tasks addObject:task];
}

- (Task*)findTaskById:(int)id
{
    for (Task* task in self.tasks)
    {
        if ([task id] == id)
        {
            return task;
        }
    }
    return nil;
}

- (void)onResponseSuccessful:(id)data
{
    self.tasks = data;
    [self postData];
}

- (void)onResponseFailure:(NSError*)error
{
    
}

@end
