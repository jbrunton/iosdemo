//
//  TimeHelperTests.m
//  iosdemo
//
//  Created by John Brunton on 20/12/2013.
//  Copyright (c) 2013 John Brunton. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TimeHelper.h"

@interface TimeHelperTests : XCTestCase

@end

@implementation TimeHelperTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testFormat
{
    TimeHelper *timeHelper = [[TimeHelper alloc] init];
    
    NSDateFormatter *tempFormatter = [[NSDateFormatter alloc] init];
    [tempFormatter setDateFormat:@"yyyy-mm-dd hh:mm:ss"];
    NSDate *date = [tempFormatter dateFromString:@"2014-01-01 09:00:00"];
    
    NSString* expected = @"Jan 1 2014";
    
    XCTAssertTrue([[timeHelper prettyFormat:date] isEqualToString:expected],
                  @"Strings are not equal %@ %@", expected, [timeHelper prettyFormat:date]);
}

@end
