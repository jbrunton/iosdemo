//
//  TimeHelperTests.m
//  iosdemo
//
//  Created by John Brunton on 20/12/2013.
//  Copyright (c) 2013 John Brunton. All rights reserved.
//

#import "TimeHelper.h"
#import "Kiwi.h"

SPEC_BEGIN(TimeHelperSpec)

describe (@"TimeHelper", ^{
    __block TimeHelper *timeHelper;
    
    beforeEach(^{
        timeHelper = [[TimeHelper alloc] init];
    });
    
    context (@"#prettyFormat", ^{
        it (@"formats dates", ^{
            NSDateFormatter *tempFormatter = [[NSDateFormatter alloc] init];
            [tempFormatter setDateFormat:@"yyyy-mm-dd hh:mm:ss"];
            NSDate *date = [tempFormatter dateFromString:@"2014-01-01 09:00:00"];
            
            NSString* expected = @"Jan 1 2014";
            
            [[[timeHelper prettyFormat:date] should] equal:expected];
        });
    });
    
    context (@"formatAsTimestamp", ^{
        it (@"returns a string representation of the date", ^{
            NSDate* date = [timeHelper timeWithYear:2014 month:2 day:4 hour:8 minute:16];
            [[[timeHelper formatAsTimestamp:date] should] equal:@"2014-02-04T08:16:00.000Z"];
        });
        
        it (@"represents midnight as 00:00", ^{
            NSDate* date = [timeHelper timeWithYear:2014 month:2 day:4 hour:0 minute:0];
            [[[timeHelper formatAsTimestamp:date] should] equal:@"2014-02-04T00:00:00.000Z"];
        });
    });
    
    context (@"#parseTimestamp", ^{
        it (@"parses UTC timestamps", ^{
            NSString* timestamp = @"2014-02-04T08:16:00.000Z";
            
            NSDate* parsedDate = [timeHelper parseTimestamp:timestamp];
            
            NSDate* expectedDate = [timeHelper timeWithYear:2014 month:2 day:4 hour:8 minute:16];
            
            [[theValue([parsedDate compare:expectedDate]) should] equal:theValue(NSOrderedSame)];
        });
    });


    context (@"#dateFromComponents", ^{
        it (@"returns a date from the given components", ^{
            NSDateComponents* components = [[NSDateComponents alloc] init];
            [components setYear:2014];
            [components setMonth:1];
            [components setDay:1];
            [components setHour:18];
            [components setMinute:30];
            
            NSDate* date = [timeHelper dateFromComponents:components];
            
            [[[timeHelper formatAsTimestamp:date] should] equal:@"2014-01-01T18:30:00.000Z"];
        });
    });
    
    context (@"#componentsForDate", ^{
        __block NSDateComponents* components;
        
        beforeEach(^{
            NSDate* date = [timeHelper timeWithYear:2014 month:2 day:4 hour:8 minute:16];
            components = [timeHelper componentsForDate:date];
        });
        
        it (@"returns the year component", ^{
            [[theValue([components year]) should] equal:theValue(2014)];
        });
        
        it (@"returns the month component", ^{
            [[theValue([components month]) should] equal:theValue(2)];
        });

        it (@"returns the day component", ^{
            [[theValue([components day]) should] equal:theValue(4)];
        });
        
        it (@"returns the hour component", ^{
            [[theValue([components hour]) should] equal:theValue(8)];
        });
        
        it (@"returns the minute component", ^{
            [[theValue([components minute]) should] equal:theValue(16)];
        });
    });
    
    context(@"#dateFromComponents", ^{
        it (@"constructs a date from the given components", ^{
            NSDateComponents* components = [[NSDateComponents alloc] init];
            [components setYear:2014];
            [components setMonth:2];
            [components setDay:4];
            [components setHour:8];
            [components setMinute:16];
            [components setSecond:32];
            
            NSDate* date = [timeHelper dateFromComponents:components];
            
            [[[timeHelper formatAsTimestamp:date] should] equal:@"2014-02-04T08:16:32.000Z"];
        });
    });

    context (@"#dateWithYear", ^{
        it (@"constructs a date from the given components", ^{
            NSDate* date = [timeHelper dateWithYear:2014 month:02 day:04];
            [[[timeHelper formatAsTimestamp:date] should] equal:@"2014-02-04T00:00:00.000Z"];
        });
    });
    
    context (@"#timeWithYear", ^{
        it (@"constructs a date from the given components", ^{
            NSDate* date = [timeHelper timeWithYear:2014 month:2 day:4 hour:8 minute:16];
            [[[timeHelper formatAsTimestamp:date] should] equal:@"2014-02-04T08:16:00.000Z"];
        });
    });
});

SPEC_END
