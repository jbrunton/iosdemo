#import "Kiwi.h"

#import "TasksViewController.h"

// helper method to instantiate controllers
// TODO: move this out of this spec file
@interface UIStoryboard (HelperMethods)

+ (UIViewController*)instantiateAndLoad:(NSString*)identifier;

@end

@implementation UIStoryboard (HelperMethods)

+ (UIViewController *)instantiateAndLoad:(NSString *)identifier
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    UIViewController* controller = [storyboard instantiateViewControllerWithIdentifier:identifier];
    [controller performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];
    return controller;
}


@end

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
            NSNotificationCenter* notifcationCenter = [NSNotificationCenter nullMock];
            [controller registerWith:notifcationCenter];
            
            [[notifcationCenter should] receive:@selector(postNotificationName:object:) withArguments:@"TasksRequest", nil];
            
            [controller viewDidLoad];
        });
    });
});

SPEC_END
