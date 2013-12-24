//
//  TimeHelper.h
//  iosdemo
//
//  Created by John Brunton on 20/12/2013.
//  Copyright (c) 2013 John Brunton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeHelper : NSObject

- (NSString*)prettyFormat:(NSDate*)date;

- (NSString*)formatAsTimestamp:(NSDate*)date;
- (NSDate*)parseTimestamp:(NSString*)timestamp;

- (NSDateComponents*)componentsForDate:(NSDate*)date;
- (NSDate*)dateFromComponents:(NSDateComponents*)components;

- (NSDate*)dateWithYear:(int)year month:(int)month day:(int)day;
- (NSDate*)timeWithYear:(int)year month:(int)month day:(int)day hour:(int)hour minute:(int)minute;

@end
