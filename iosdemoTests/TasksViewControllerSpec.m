#import "Kiwi.h"

#import "TasksViewController.h"

SPEC_BEGIN(TasksViewControllerSpec)

describe(@"TasksViewController", ^{
    
    __block TasksViewController* controller;
    __block DataSource* dataSource;
    
    beforeEach(^{
        dataSource = [DataSource mock];
        controller = [[TasksViewController alloc] init];
        [controller setDataSource:dataSource];
    });
    
    context(@"#registerWith:", ^{
        it (@"subscribes to the TasksAvailable event", ^{
            NSNotificationCenter* notificationCenter = [NSNotificationCenter mock];
            
            [[notificationCenter should] receive:@selector(addObserver:selector:name:object:)
                                   withArguments:controller, any(), @"TasksAvailable", any()];
            
            [controller registerWith:notificationCenter];
        });
    });
    
    context(@"#viewDidLoad", ^{
        
        beforeEach(^{
            [controller viewDidLoad];
        });
        
        it (@"assigns the data source as the table view's delegate and data source", ^{
            //[[theObject(controller.tableView.delegate) should] beIdenticalTo:nil];
            //[[controller.tableView.dataSource should] equal:dataSource];
        });
        
        
        it (@"posts the TasksRequest event", ^{
            NSNotificationCenter* notifcationCenter = [NSNotificationCenter nullMock];
            [controller registerWith:notifcationCenter];
            
            [[notifcationCenter should] receive:@selector(postNotificationName:object:) withArguments:@"TasksRequest", nil];
            
            [controller viewDidLoad];
        });
    });
});

SPEC_END
