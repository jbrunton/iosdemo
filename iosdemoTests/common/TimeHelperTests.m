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

describe(@"TimeHelper", ^{
    it(@"formats dates", ^{
        TimeHelper *timeHelper = [[TimeHelper alloc] init];
        
        NSDateFormatter *tempFormatter = [[NSDateFormatter alloc] init];
        [tempFormatter setDateFormat:@"yyyy-mm-dd hh:mm:ss"];
        NSDate *date = [tempFormatter dateFromString:@"2014-01-01 09:00:00"];
        
        NSString* expected = @"Jan 1 2014";

        [[[timeHelper prettyFormat:date] should] equal:expected];
    });
});

SPEC_END
