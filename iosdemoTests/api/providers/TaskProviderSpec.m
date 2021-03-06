//
//  TaskProvderSpec.m
//  iosdemo
//
//  Created by John Brunton on 21/12/2013.
//  Copyright (c) 2013 John Brunton. All rights reserved.
//

#define EXP_SHORTHAND

#import "TaskProvider.h"
#import "Specta.h"
#import "Expecta.h"

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

SpecBegin(TaskProviderSpec)

describe (@"TaskProvider", ^{
    __block TaskProvider* provider;
    
    beforeEach(^{
        provider = [[TaskProvider alloc] init];
    });
    
    context(@"#registerWith", ^{
        it (@"registers itself with the given notification center", ^{
            NSNotificationCenter* notificationCenter = mock([NSNotificationCenter class]);
            
            [provider registerWith:notificationCenter];

            [verify(notificationCenter) addObserver:provider
                                            selector:@selector(onTasksRequest:)
                                                name:@"TasksRequest"
                                              object:anything()];
        });
    });
    
    context(@"#onTasksRequest", ^{
        it (@"sends a TasksAvailable notification if it has available data", ^{
            NSNotificationCenter* notificationCenter = mock([NSNotificationCenter class]);
            [provider registerWith:notificationCenter];
            provider.tasks = [NSMutableArray arrayWithObject:[[Task alloc] init]];
            
            [provider onTasksRequest:nil];

            [verify(notificationCenter) postNotificationName:@"TasksAvailable"
                                                      object:anything()
                                                    userInfo:anything()];
            
        });
    });
    
//    context (@"#addTask", ^{
//        it (@"adds a task to the provider", ^{
//            Task* task = [[Task alloc] init];
//            [provider addTask:task];
//            [[[provider tasks] should] contain:task];
//        });
//    });
//    
//    context (@"#findTaskById", ^{
//        it (@"returns the task for the given id if present", ^{
//            Task* expectedTask = [[Task alloc] initWithId:1
//                                           andDescription:nil
//                                               andDueDate:nil];
//            [provider addTask:expectedTask];
//            
//            Task* task = [provider findTaskById:1];
//            
//            [[task shouldNot] beNil];
//        });
//        
//        it(@"return nil when no task is present", ^{
//            Task* task = [provider findTaskById:1];
//            [[task should] beNil];
//        });
//    });
});

SpecEnd

