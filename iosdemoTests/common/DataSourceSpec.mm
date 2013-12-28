//
//  DataSourceSpec.m
//  iosdemo
//
//  Created by John Brunton on 25/12/2013.
//  Copyright (c) 2013 John Brunton. All rights reserved.
//

#import "SpecHelper.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

#import "DataSource.h"

// expose private methods for testing
// TODO: consider alternatives.
@interface DataSource (PrivateMethods)

- (UITableViewCell*)createCell;

@end

SPEC_BEGIN(DataSourceSpec)

describe(@"DataSourceSpec", ^{
    
    __block DataSource* dataSource;
    __block id tableView;

    beforeEach(^{
        dataSource = [[DataSource alloc] init];
        tableView = nice_fake_for([UITableView class]);
    });
    
    it (@"defines a tableview with one section", ^{
        [dataSource numberOfSectionsInTableView:nil] should equal(1);
    });
        
    context (@"#tableView:numberOfRowsInSection:", ^{
        
        it (@"returns the number of rows in the section", ^{
            [dataSource setData:[[NSArray alloc] initWithObjects:
                                 [NSNumber numberWithInt:1],
                                 [NSNumber numberWithInt:2],
                                 [NSNumber numberWithInt:3], nil]];
            
            [dataSource tableView:tableView numberOfRowsInSection:0] should equal(3);
        });
        
        it (@"throws an error for invalid sections", ^{
            ^{
                [dataSource tableView:tableView numberOfRowsInSection:1];
            } should raise_exception;
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
            ^{
                [dataSource tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
            } should raise_exception;
        });
        
        it (@"defines cells only up to the length of its data", ^{
            ^{
                [dataSource tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
            } should raise_exception;
        });
        
        it (@"creates a cell when none are available for reuse", ^{
            tableView stub_method("dequeueReusableCellWithIdentifier:forIndexPath:").and_return((UITableViewCell*)nil);
            
            UITableViewCell* cell = [dataSource tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            
            cell.textLabel.text should equal(@"123");
        });

        it (@"reuses cells when there is one available for reuse", ^{
            UITableViewCell* expectedCell = [dataSource createCell];
            tableView stub_method("dequeueReusableCellWithIdentifier:forIndexPath:").and_return(expectedCell);
            
            UITableViewCell* cell = [dataSource tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            
            cell should equal(expectedCell);
            cell.textLabel.text should equal(@"123");
        });
    });

    context (@"#tableView:canEditRowAtIndexPath:", ^{
        it (@"returns YES", ^{
            [dataSource tableView:tableView canEditRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]] should equal(YES);
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
            [dataSource tableView:tableView commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
            
            tableView should have_received("deleteRowsAtIndexPaths:withRowAnimation:");
            
            [[dataSource getData] count] should equal(2);
            [dataSource getData] should contain(itemOne);
            [dataSource getData] should contain(itemThree);
        });
        
        it (@"removes the correct item from the table view", ^{
            NSIndexPath* indexPath = [NSIndexPath indexPathForRow:1 inSection:0];

            [dataSource tableView:tableView commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:indexPath];
            
            tableView should have_received("deleteRowsAtIndexPaths:withRowAnimation:").with(@[indexPath]).and_with(Arguments::anything);
        });
    });
});

SPEC_END
