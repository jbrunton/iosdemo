//
//  TaskGatewaySpec.m
//  iosdemo
//
//  Created by John Brunton on 21/12/2013.
//  Copyright (c) 2013 John Brunton. All rights reserved.
//

#import "TaskGateway.h"
#import "Kiwi.h"

SPEC_BEGIN(TaskGatewaySpec)

describe (@"TaskGateway", ^{
    context(@"#initWithRequestManager", ^{
        AFHTTPRequestOperationManager* requestManager = [AFHTTPRequestOperationManager mock];
        TaskGateway* gateway = [[TaskGateway alloc] initWithRequestManager:requestManager];
        
        it (@"sets the requestManager property", ^{
            [[[gateway requestManager] should] equal:requestManager];
        });
    });
    
    context(@"#requestData", ^{
        __block id delegate;
        __block AFHTTPRequestOperationManager* requestManager;
        __block TaskGateway* gateway;
        
        beforeEach(^{
            delegate = [KWMock mockForProtocol:@protocol(GatewayResponseDelegate)];
            requestManager = [AFHTTPRequestOperationManager mock];
            gateway = [[TaskGateway alloc] initWithRequestManager:requestManager];
        });
        
        it (@"calls GET on the request manager", ^{
            [[requestManager should] receive:@selector(GET:parameters:success:failure:)
                               withArguments:@"http://localhost:3000/tasks.json",any(),any(),any()];
            
            [gateway requestData:delegate];
        });
        
        it (@"invokes the delegate's onResponseSuccessful method if the request is successful", ^{
            KWCaptureSpy *spy = [requestManager captureArgument:@selector(GET:parameters:success:failure:) atIndex:2];
            
            [[delegate should] receive:@selector(onResponseSuccessful:)];
            
            [gateway requestData:delegate];
            
            void (^success)(AFHTTPRequestOperation *, id *) = spy.argument;
            success(nil,nil);
        });
        
        it (@"invokes the delegate's onResponseError method if the request fails", ^{
            KWCaptureSpy *spy = [requestManager captureArgument:@selector(GET:parameters:success:failure:) atIndex:3];
            
            [[delegate should] receive:@selector(onResponseError:)];
            
            [gateway requestData:delegate];
            
            void (^failure)(AFHTTPRequestOperation *, NSError *) = spy.argument;
            failure(nil,nil);
        });
    });
});

SPEC_END
