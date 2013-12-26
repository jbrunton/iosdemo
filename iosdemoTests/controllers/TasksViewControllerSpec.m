#import "Kiwi.h"

#import "HelperMethods.h"

#import "TasksViewController.h"
#import "TaskDetailViewController.h"

SPEC_BEGIN(TasksViewControllerSpec)

describe(@"TasksViewController", ^{
    
    __block TasksViewController* controller;
    __block DataSource* dataSource;
    
    beforeEach(^{
        controller = (TasksViewController*)[UIStoryboard instantiateAndLoad:@"TasksViewController"];
        dataSource = [DataSource mock];
        controller.dataSource = dataSource;
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
            [[theValue(controller.tableView.dataSource) should] equal:theValue(dataSource)];
            [[theValue(controller.tableView.delegate) should] equal:theValue(dataSource)];
        });
        
        
        it (@"posts the TasksRequest event", ^{
            NSNotificationCenter* notificationCenter = [NSNotificationCenter nullMock];
            [controller registerWith:notificationCenter];
            
            [[notificationCenter should] receive:@selector(postNotificationName:object:) withArguments:@"TasksRequest", nil];
            
            [controller viewDidLoad];
        });
    });
    
    context(@"#prepareForSegue:sender:", ^{
        it (@"sets the selected task on the detail controller", ^{
            TaskDetailViewController* detailController = [TaskDetailViewController mock];
            UIStoryboardSegue* segue = [UIStoryboardSegue segueWithIdentifier:@"showDetail" source:controller destination:detailController performHandler:^{}];
            
            Task* selectedTask = [Task mock];

            [[dataSource should] receive:@selector(itemAt:)
                               andReturn:selectedTask
                           withArguments:any()];
            
            [[detailController should] receive:@selector(setTask:) withArguments:selectedTask];
            
            [controller prepareForSegue:segue sender:nil];
        });
    });
});

SPEC_END
