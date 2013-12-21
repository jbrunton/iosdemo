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

describe (@"Task", ^{
    context (@"#initWithId:andDescription:andDueDate", ^{
        int expectedId = 1;
        NSString* expectedDescription = @"Some Task";
        NSDate* expectedDate = [NSDate date];

        __block id task;
        
        beforeEach(^{
            task = [[Task alloc] initWithId:expectedId
                                   andDescription:expectedDescription
                                       andDueDate:expectedDate];
        });

        it (@"initializes the task's id", ^{
            [[theValue([task id]) should] equal:theValue(expectedId)];
        });
        
        it (@"initializes the task's description", ^{
            [[[task description] should] equal:expectedDescription];
        });
        
        it (@"initializes the task's due date", ^{
            [[[task due] should] equal:expectedDate];
        });
    });
});

SPEC_END
