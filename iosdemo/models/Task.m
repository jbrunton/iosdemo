//
//  TodoItem.m
//  iosdemo
//
//  Created by John Brunton on 21/12/2013.
//  Copyright (c) 2013 John Brunton. All rights reserved.
//

#import "Task.h"

@implementation Task

- (id)initWithId:(int)id andDescription:(NSString*)description andDueDate:(NSDate*)dueDate
{
    self = [self init];
    if (self) {
        self.id = id;
        self.description = description;
        self.dueDate = dueDate;
    }
    return self;
}

- (id)initWithDictionary:(id)dictionary
{
    return [self initWithId:[dictionary[@"id"] intValue]
             andDescription:dictionary[@"description"]
                andDueDate:nil];
}

@end
