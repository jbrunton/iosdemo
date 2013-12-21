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
    it (@"has an array of tasks", ^{
        TaskProvider* provider = [[TaskProvider alloc] init];
        [[[provider tasks] shouldNot] beNil];
    });
    context (@"#addTask", ^{
        it (@"adds a task to the provider", ^{
            TaskProvider* provider = [[TaskProvider alloc] init];
            Task* task = [[Task alloc] init];
            
            [provider addTask:task];
            
            [[[provider tasks] should] contain:task];
        });
    });
    
    context (@"#findTaskById", ^{
        __block TaskProvider* provider;
        
        beforeEach (^{
            provider = [[TaskProvider alloc] init];
        });
        
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