//
//  DataSourceSpec.m
//  iosdemo
//
//  Created by John Brunton on 25/12/2013.
//  Copyright (c) 2013 John Brunton. All rights reserved.
//

#import "Kiwi.h"

#import "DataSource.h"

// expose private methods for testing
// TODO: consider alternatives.
@interface DataSource (PrivateMethods)

- (UITableViewCell*)createCell;

@end

SPEC_BEGIN(DataSourceSpec)

describe(@"DataSourceSpec", ^{
    
    __block DataSource* dataSource;
    __block UITableView* tableView;

    beforeEach(^{
        dataSource = [[DataSource alloc] init];
        tableView = [UITableView mock];
    });
    
    it (@"defines a tableview with one section", ^{
        [[theValue([dataSource numberOfSectionsInTableView:nil]) should] equal:theValue(1)];
    });
        
    context (@"#tableView:numberOfRowsInSection:", ^{
        
        it (@"returns the number of rows in the section", ^{
            [dataSource setData:[[NSArray alloc] initWithObjects:
                                 [NSNumber numberWithInt:1],
                                 [NSNumber numberWithInt:2],
                                 [NSNumber numberWithInt:3], nil]];
            
            [[theValue([dataSource tableView:tableView numberOfRowsInSection:0]) should] equal:theValue(3)];
        });
        
        it (@"throws an error for invalid sections", ^{
            [[theBlock(^{
                [dataSource tableView:tableView numberOfRowsInSection:1];
            }) should] raise];
        });
    });
    
    context (@"#tableView:cellForRowAtIndexPath:", ^{
        
        beforeEach(^{
            [dataSource setData:[[NSArray alloc] initWithObjects:
                                 [NSNumber numberWithInt:123],
                                 [NSNumber numberWithInt:456],
                                 [NSNumber numberWithInt:789], nil]];
        });
        
        it (@"expects one section", ^{
            [[theBlock(^{
                [dataSource tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
            }) should] raise];
        });
        
        it (@"defines cells only up to the length of its data", ^{
            [[theBlock(^{
                [dataSource tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
            }) should] raise];
        });
        
        it (@"creates a cell when none are available for reuse", ^{
            [[tableView should] receive:@selector(dequeueReusableCellWithIdentifier:forIndexPath:) andReturn:nil];
            
            UITableViewCell* cell = [dataSource tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            
            [[cell.textLabel.text should] equal:@"123"];
        });
        
        it (@"reuses cells when there is one available for reuse", ^{
            UITableViewCell* expectedCell = [dataSource createCell];
            [[tableView should] receive:@selector(dequeueReusableCellWithIdentifier:forIndexPath:) andReturn:expectedCell];
            
            UITableViewCell* cell = [dataSource tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            
            [[cell should] equal:expectedCell];
            [[cell.textLabel.text should] equal:@"123"];
        });
    });
    
    context (@"#tableView:canEditRowAtIndexPath:", ^{
        it (@"returns YES", ^{
            [[theValue([dataSource tableView:tableView canEditRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]) should] equal:theValue(YES)];
        });
    });
    
    context (@"#tableView:commitEditingStyle:forRowAtIndexPath:", ^{
        __block id itemOne, itemTwo, itemThree;
        
        beforeEach(^{
            itemOne = [[NSObject alloc] init];
            itemTwo = [[NSObject alloc] init];
            itemThree = [[NSObject alloc] init];
            [dataSource setData:[[NSArray alloc] initWithObjects:itemOne, itemTwo, itemThree, nil]];
        });

        it (@"removes the item from the data source", ^{
            [[tableView should] receive:@selector(deleteRowsAtIndexPaths:withRowAnimation:)];
            
            [dataSource tableView:tableView commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
            
            
            [[[dataSource getData] should] haveCountOf:2];
            [[[dataSource getData] should] containObjects:itemOne, itemThree, nil];
        });
        
        it (@"removes the correct item from the table view", ^{
            NSIndexPath* indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
            [[tableView should] receive:@selector(deleteRowsAtIndexPaths:withRowAnimation:)
                          withArguments:@[indexPath], any()];
            
            [dataSource tableView:tableView commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:indexPath];
        });
    });
});

SPEC_END
