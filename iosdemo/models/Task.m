//
//  TodoItem.m
//  iosdemo
//
//  Created by John Brunton on 21/12/2013.
//  Copyright (c) 2013 John Brunton. All rights reserved.
//

#import "Task.h"

@implementation Task

- (id)initWithId:(int)id andDescription:(NSString*)description andDueDate:(NSDate*)due
{
    self = [super init];
    if (self) {
        self.id = id;
        self.description = description;
        self.due = due;
    }
    return self;
}

@end
