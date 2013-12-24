//
//  TaskProvider.h
//  iosdemo
//
//  Created by John Brunton on 21/12/2013.
//  Copyright (c) 2013 John Brunton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Task.h"
#import "TaskGateway.h"

@interface TaskProvider : NSObject <GatewayResponseDelegate>

@property (nonatomic) NSMutableArray* tasks;
@property (nonatomic) NSNotificationCenter* notificationCenter;
@property (nonatomic) TaskGateway* gateway;

// TODO: should this be part of an init method?
- (void)registerWith:(NSNotificationCenter*)notificationCenter;
- (void)onTasksRequest:(NSNotification*)notification;
//- (void)addTask:(Task*)task;
//- (Task*)findTaskById:(int)id;
- (TaskProvider*)initWithGateway:(TaskGateway*) gateway;

@end
