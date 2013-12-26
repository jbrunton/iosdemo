#import "Kiwi.h"

#import "HelperMethods.h"

#import "TaskDetailViewController.h"

SPEC_BEGIN(TaskDetailViewControllerSpec)

describe(@"TaskDetailViewController", ^{
    
    __block TaskDetailViewController* controller;
    
    beforeEach(^{
        controller = (TaskDetailViewController*)[UIStoryboard instantiateAndLoad:@"TaskDetailViewController"];
    });
    
    context(@"#configureView", ^{
        it (@"sets the detail description label's text to the task's description", ^{
            Task* task = [[Task alloc] initWithId:1 andDescription:@"Some Task" andDueDate:nil];
            controller.task = task;
            
            [controller configureView];

            [[controller.detailDescriptionLabel.text should] equal:@"Some Task"];
        });
    });
    
    context(@"#viewDidLoad", ^{
        it (@"configures the view", ^{
            [[controller should] receive:@selector(configureView)];
            [controller viewDidLoad];
        });
    });
});

SPEC_END
