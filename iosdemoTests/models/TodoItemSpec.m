//
//  TodoItemSpec.m
//  iosdemo
//
//  Created by John Brunton on 21/12/2013.
//  Copyright (c) 2013 John Brunton. All rights reserved.
//

#import "TodoItem.h"
#import "Kiwi.h"

SPEC_BEGIN(TodoItemSpec)

describe(@"TodoItem", ^{
    context(@"#initWithDescription:andDueDate", ^{
        it(@"initializes the item's description", ^{
            TodoItem* item = [[TodoItem alloc] initWithDescription:@"Some Item" andDueDate:nil];
            [[[item description] should] equal:@"Some Item"];
        });
        
        it(@"initializes the item's due date", ^{
            NSDate* dueDate = [NSDate date];
            TodoItem* item = [[TodoItem alloc] initWithDescription:nil andDueDate:dueDate];
            [[[item due] should] equal:dueDate];
        });
    });
});

SPEC_END
