//
//  TaskProvderSpec.m
//  iosdemo
//
//  Created by John Brunton on 21/12/2013.
//  Copyright (c) 2013 John Brunton. All rights reserved.
//

#import "TaskProvider.h"
#import "Kiwi.h"

SPEC_BEGIN(TaskProviderSpec)

describe (@"TaskProvider", ^{
    __block TaskProvider* provider;
    
    beforeEach(^{
        provider = [[TaskProvider alloc] init];
    });
    
    it (@"has an array of tasks", ^{
        [[[provider tasks] shouldNot] beNil];
    });
    
    context(@"#registerWith", ^{
        it (@"registers itself with the given notification center", ^{
            NSNotificationCenter* notificationCenter = [NSNotificationCenter nullMock];
            
            [[notificationCenter should] receive:@selector(addObserver:selector:name:object:)
                                   withArguments:provider, any(), @"TasksRequest", any()];
            
            [provider registerWith:notificationCenter];
        });
    });
    
    context(@"#onTasksRequest", ^{
        it (@"sends a TasksAvailable notification if it has available data", ^{
            NSNotificationCenter* notificationCenter = [NSNotificationCenter nullMock];
            [provider registerWith:notificationCenter];
            provider.tasks = [NSMutableArray arrayWithObject:[[Task alloc] init]];
            
            [[notificationCenter should] receive:@selector(postNotificationName:object:userInfo:)
                                   withArguments:@"TasksAvailable", any(), any()];
            
            [provider onTasksRequest:nil];
        });
    });
    
    context (@"#addTask", ^{
        it (@"adds a task to the provider", ^{
            Task* task = [[Task alloc] init];
            [provider addTask:task];
            [[[provider tasks] should] contain:task];
        });
    });
    
    context (@"#findTaskById", ^{
        it (@"returns the task for the given id if present", ^{
            Task* expectedTask = [[Task alloc] initWithId:1
                                           andDescription:nil
                                               andDueDate:nil];
            [provider addTask:expectedTask];
            
            Task* task = [provider findTaskById:1];
            
            [[task shouldNot] beNil];
        });
        
        it(@"return nil when no task is present", ^{
            Task* task = [provider findTaskById:1];
            [[task should] beNil];
        });
    });
});

SPEC_END