//
//  TodoItemSpec.m
//  iosdemo
//
//  Created by John Brunton on 21/12/2013.
//  Copyright (c) 2013 John Brunton. All rights reserved.
//

#define EXP_SHORTHAND

#import "Task.h"
#import "Specta.h"
#import "Expecta.h"

SpecBegin(TaskSpec)

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
            expect([task id]).to.equal(expectedId);
        });
        
        it (@"initializes the task's description", ^{
            expect([task description]).to.equal(expectedDescription);
        });
        
        it (@"initializes the task's due date", ^{
            expect([task dueDate]).to.equal(expectedDate);
        });
    });
    
    context(@"#initWithDictionary", ^{
        NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"1", @"id",
                              @"Some Task", @"description",
                              @"2014-01-01T18:00:00.000Z", @"due_date",
                              nil];
        
        __block id task;
        
        beforeEach(^{
            task = [[Task alloc] initWithDictionary:dict];
        });
        
        it (@"initializes the task's id", ^{
            expect([task id]).to.equal(1);
        });
        
        it (@"initializes the task's description", ^{
            expect([task description]).to.equal(@"Some Task");
        });
        
        it (@"initializes the task's due date", ^{
            // [[theValue([task id]) should] equal:theValue(1)];
        });
    });
});

SpecEnd
