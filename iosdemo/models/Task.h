//
//  TodoItem.h
//  iosdemo
//
//  Created by John Brunton on 21/12/2013.
//  Copyright (c) 2013 John Brunton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject

@property (assign, nonatomic) int id;
@property (strong, nonatomic) NSString* description;
@property (strong, nonatomic) NSDate* due;

- (id)initWithDescription:(NSString*)description andDueDate:(NSDate*)due;

@end


