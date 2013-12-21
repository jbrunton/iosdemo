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
                           selector:@selector(onRequestTasks:)
                               name:@"TasksRequest"
                             object:nil];
}

- (void)onRequestTasks:(NSNotification*)notification
{
    NSDictionary* userInfo = [NSDictionary dictionaryWithObject:self.tasks forKey:@"data"];
    [self.notificationCenter postNotificationName:@"TasksAvailable"
                                           object:nil
                                         userInfo:userInfo];
}

- (id)init
{
    self = [super init];
    if (self) {
        self.tasks = [[NSMutableArray alloc] init];
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

@end
