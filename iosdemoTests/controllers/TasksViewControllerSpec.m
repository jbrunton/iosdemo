#define EXP_SHORTHAND

#import "TasksViewController.h"
#import "TaskDetailViewController.h"

#import "Specta.h"
#import "Expecta.h"

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

#import "HelperMethods.h"

SpecBegin(TasksViewControllerSpec)

describe(@"TasksViewController", ^{
    
    __block TasksViewController* controller;
    __block DataSource* dataSource;
    
    beforeEach(^{
        controller = (TasksViewController*)[UIStoryboard instantiateAndLoad:@"TasksViewController"];
        dataSource = mock([DataSource class]);
        controller.dataSource = dataSource;
    });
    
    context(@"#registerWith:", ^{
        it (@"subscribes to the TasksAvailable event", ^{
            NSNotificationCenter* notificationCenter = mock([NSNotificationCenter class]);
            
            [controller registerWith:notificationCenter];
            
            [verify(notificationCenter) addObserver:controller
                                           selector:NSSelectorFromString(@"onTasksAvailable:")
                                               name:@"TasksAvailable"
                                             object:anything()];
            
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
            NSNotificationCenter* notificationCenter = mock([NSNotificationCenter class]);
            [controller registerWith:notificationCenter];
            
            [controller viewDidLoad];
            
            [verify(notificationCenter) postNotificationName:@"TasksRequest"
                                                      object:nil];
        });
    });
    
    context(@"#prepareForSegue:sender:", ^{
        it (@"sets the selected task on the detail controller", ^{
            // arrange
            TaskDetailViewController* detailController = mock([TaskDetailViewController class]);
            UIStoryboardSegue* segue = [UIStoryboardSegue segueWithIdentifier:@"showDetail" source:controller destination:detailController performHandler:^{}];
            
            Task* selectedTask = mock([Task class]);

            [given([dataSource itemAt:anything()]) willReturn:selectedTask];
            
            // act
            [controller prepareForSegue:segue sender:nil];
            
            // assert
            [verify(detailController) setTask:selectedTask];
        });
    });
});

SpecEnd
