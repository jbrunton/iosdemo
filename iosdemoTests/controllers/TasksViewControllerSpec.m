#define EXP_SHORTHAND

#import "TasksViewController.h"
#import "TaskDetailViewController.h"

#import "Specta.h"
#import "Expecta.h"
#import "OCMock.h"

#import "HelperMethods.h"

SpecBegin(TasksViewControllerSpec)

describe(@"TasksViewController", ^{
    
    __block TasksViewController* controller;
    __block id dataSource;
    
    beforeEach(^{
        controller = (TasksViewController*)[UIStoryboard instantiateAndLoad:@"TasksViewController"];
        dataSource = [OCMockObject mockForClass:[DataSource class]];
        controller.dataSource = dataSource;
    });
    
    context(@"#registerWith:", ^{
        it (@"subscribes to the TasksAvailable event", ^{
            id notificationCenter = [OCMockObject mockForClass:[NSNotificationCenter class]];
            
            [[notificationCenter expect] addObserver:controller
                                            selector:[OCMArg anySelector]
                                                name:@"TasksAvailable"
                                              object:OCMOCK_ANY];
            
            [controller registerWith:notificationCenter];
            
            [notificationCenter verify];
        });
    });
    
    context(@"#viewDidLoad", ^{        
        beforeEach(^{
            [controller viewDidLoad];
        });
        
        it (@"assigns the data source as the table view's delegate and data source", ^{
            expect(controller.tableView.dataSource).to.equal(dataSource);
            expect(controller.tableView.delegate).to.equal(dataSource);
        });
        
        
        it (@"posts the TasksRequest event", ^{
            id notificationCenter = [OCMockObject niceMockForClass:[NSNotificationCenter class]];
            [controller registerWith:notificationCenter];
            
            [[notificationCenter expect] postNotificationName:@"TasksRequest"
                                                       object:nil];
            
            [controller viewDidLoad];
            
            [notificationCenter verify];
        });
    });
    
    context(@"#prepareForSegue:sender:", ^{
        it (@"sets the selected task on the detail controller", ^{
            id detailController = [OCMockObject mockForClass:[TaskDetailViewController class]];
            UIStoryboardSegue* segue = [UIStoryboardSegue segueWithIdentifier:@"showDetail" source:controller destination:detailController performHandler:^{}];
            
            Task* selectedTask = [OCMockObject mockForClass:[Task class]];

            [[[dataSource stub] andReturn:selectedTask] itemAt:OCMOCK_ANY];
            
            [[detailController expect] setTask:selectedTask];
            
            [controller prepareForSegue:segue sender:nil];
            
            [detailController verify];
        });
    });
});

SpecEnd
