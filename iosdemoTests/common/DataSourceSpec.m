//
//  DataSourceSpec.m
//  iosdemo
//
//  Created by John Brunton on 25/12/2013.
//  Copyright (c) 2013 John Brunton. All rights reserved.
//

#define EXP_SHORTHAND

#import "DataSource.h"
#import "Specta.h"
#import "Expecta.h"

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

// expose private methods for testing
// TODO: consider alternatives.
@interface DataSource (PrivateMethods)

- (UITableViewCell*)createCell;

@end

SpecBegin(DataSourceSpec)

describe(@"DataSourceSpec", ^{
    
    __block DataSource* dataSource;
    __block id tableView;

    beforeEach(^{
        dataSource = [[DataSource alloc] init];
        tableView = mock([UITableView class]);
    });
    
    it (@"defines a tableview with one section", ^{
        expect([dataSource numberOfSectionsInTableView:nil]).to.equal(1);
    });
        
    context (@"#tableView:numberOfRowsInSection:", ^{
        
        it (@"returns the number of rows in the section", ^{
            [dataSource setData:[[NSArray alloc] initWithObjects:
                                 [NSNumber numberWithInt:1],
                                 [NSNumber numberWithInt:2],
                                 [NSNumber numberWithInt:3], nil]];
            
            expect([dataSource tableView:tableView numberOfRowsInSection:0]).to.equal(3);
        });
        
        it (@"throws an error for invalid sections", ^{
            expect(^{
                [dataSource tableView:tableView numberOfRowsInSection:1];
            }).to.raise;
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
            expect(^{
                [dataSource tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
            }).to.raise;
        });
        
        it (@"defines cells only up to the length of its data", ^{
            expect(^{
                [dataSource tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
            }).to.raise;
        });
        
        it (@"creates a cell when none are available for reuse", ^{
            [given([tableView dequeueReusableCellWithIdentifier:anything()
                                                   forIndexPath:anything()
                    ]) willReturn:nil];
            
            UITableViewCell* cell = [dataSource tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            
            expect(cell.textLabel.text).to.equal(@"123");
        });
        
        it (@"reuses cells when there is one available for reuse", ^{
            UITableViewCell* expectedCell = [dataSource createCell];
            [given([tableView dequeueReusableCellWithIdentifier:anything()
                                                   forIndexPath:anything()
                    ]) willReturn:expectedCell];
            
            UITableViewCell* cell = [dataSource tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            
            expect(cell).to.equal(expectedCell);
            expect(cell.textLabel.text).to.equal(@"123");
        });
    });
    
    context (@"#tableView:canEditRowAtIndexPath:", ^{
        it (@"returns YES", ^{
            expect([dataSource tableView:tableView canEditRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).to.equal(YES);
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
            
            [verify(tableView) deleteRowsAtIndexPaths:anything()
                                     withRowAnimation:UITableViewRowAnimationFade];
            
            expect([dataSource getData]).to.haveCountOf(2);
            expect([dataSource getData]).to.contain(itemOne);
            expect([dataSource getData]).to.contain(itemThree);
        });
        
        it (@"removes the correct item from the table view", ^{
            NSIndexPath* indexPath = [NSIndexPath indexPathForRow:1 inSection:0];

            [dataSource tableView:tableView commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:indexPath];
            
            [verify(tableView) deleteRowsAtIndexPaths:@[indexPath]
                                     withRowAnimation:UITableViewRowAnimationFade];
        });
    });
});

SpecEnd
