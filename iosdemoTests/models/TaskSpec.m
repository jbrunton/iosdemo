//
//  TodoItemSpec.m
//  iosdemo
//
//  Created by John Brunton on 21/12/2013.
//  Copyright (c) 2013 John Brunton. All rights reserved.
//

#import "Task.h"
#import "Kiwi.h"

SPEC_BEGIN(TaskSpec)

describe(@"Task", ^{
    context(@"#initWithDescription:andDueDate", ^{
        it(@"initializes the task's description", ^{
            Task* task = [[Task alloc] initWithDescription:@"Some Item" andDueDate:nil];
            [[[task description] should] equal:@"Some Item"];
        });
        
        it(@"initializes the task's due date", ^{
            NSDate* dueDate = [NSDate date];
            Task* task = [[Task alloc] initWithDescription:nil andDueDate:dueDate];
            [[[task due] should] equal:dueDate];
        });
    });
});

SPEC_END
