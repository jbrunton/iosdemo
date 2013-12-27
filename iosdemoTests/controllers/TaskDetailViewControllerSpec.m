#define EXP_SHORTHAND

#import "TaskDetailViewController.h"

#import "Specta.h"
#import "Expecta.h"
#import "OCMock.h"

#import "HelperMethods.h"

SpecBegin(TaskDetailViewControllerSpec)

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

            expect(controller.detailDescriptionLabel.text).to.equal(@"Some Task");
        });
    });
    
    context(@"#viewDidLoad", ^{
        it (@"configures the view", ^{
            id mockController = [OCMockObject partialMockForObject:controller];
            [[[mockController expect] andForwardToRealObject] configureView];
            
            [mockController viewDidLoad];

            [mockController verify];
        });
    });
});

SpecEnd
