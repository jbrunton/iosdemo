//
//  DataSourceSpec.m
//  iosdemo
//
//  Created by John Brunton on 25/12/2013.
//  Copyright (c) 2013 John Brunton. All rights reserved.
//

#import "Kiwi.h"

#import "DataSource.h"

SPEC_BEGIN(DataSourceSpec)

describe(@"DataSourceSpec", ^{
    
    __block DataSource* dataSource;

    beforeEach(^{
        dataSource = [[DataSource alloc] init];
    });
    
    it (@"defines a tableview with one section", ^{
        [[theValue([dataSource numberOfSectionsInTableView:nil]) should] equal:theValue(1)];
    });
    
    context (@"tableView:numberOfRowsInSection:", ^{
        it (@"returns the number of rows in the section", ^{
            [[theValue([dataSource tableView:nil numberOfRowsInSection:0]) should] equal:theValue(0)];
        });
        
        it (@"throws an error for invalid sections", ^{
            [[theBlock(^{
                [dataSource tableView:nil numberOfRowsInSection:1];
            }) should] raise];
        });
    });
});

SPEC_END
