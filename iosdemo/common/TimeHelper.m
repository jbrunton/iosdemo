//
//  TimeHelper.m
//  iosdemo
//
//  Created by John Brunton on 20/12/2013.
//  Copyright (c) 2013 John Brunton. All rights reserved.
//

#import "TimeHelper.h"

@implementation TimeHelper

- (NSString*)prettyFormat:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM d y"];
    
    return [dateFormatter stringFromDate:date];
}

- (NSDateFormatter*)timestampFormatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    return dateFormatter;
}

- (NSString*)formatAsTimestamp:(NSDate*)date
{
    return [[self timestampFormatter] stringFromDate:date];
}

- (NSDate*)parseTimestamp:(NSString*)timestamp
{
    return [[self timestampFormatter] dateFromString:timestamp];
}

- (int)allCalendarComponents
{
    return NSYearCalendarUnit
        | NSMonthCalendarUnit
        | NSDayCalendarUnit
        | NSHourCalendarUnit
        | NSMinuteCalendarUnit
        | NSSecondCalendarUnit;
}

- (NSDateComponents*)componentsForDate:(NSDate*)date
{
    NSCalendar* currentCalendar = [NSCalendar currentCalendar];
    int components = [self allCalendarComponents];
    return [currentCalendar components:components
                              fromDate:date];
}

- (NSDate*)dateFromComponents:(NSDateComponents*)components
{
    NSCalendar* currentCalendar = [NSCalendar currentCalendar];
    return [currentCalendar dateFromComponents:components];
}

- (NSDate*)dateWithYear:(int)year month:(int)month day:(int)day
{
    return [self timeWithYear:year
                        month:month
                          day:day
                         hour:0
                       minute:0];
}

- (NSDate*)timeWithYear:(int)year month:(int)month day:(int)day hour:(int)hour minute:(int)minute
{
    NSDateComponents* components = [[NSDateComponents alloc] init];

    [components setYear:year];
    [components setMonth:month];
    [components setDay:day];
    [components setHour:hour];
    [components setMinute:minute];
    [components setSecond:0];
    
    return [self dateFromComponents:components];
}

@end
