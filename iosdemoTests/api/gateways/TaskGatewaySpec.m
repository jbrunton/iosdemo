//
//  TaskGatewaySpec.m
//  iosdemo
//
//  Created by John Brunton on 21/12/2013.
//  Copyright (c) 2013 John Brunton. All rights reserved.
//

#define EXP_SHORTHAND

#import "TaskGateway.h"
#import "Specta.h"
#import "Expecta.h"
#import <OCMock.h>
#import <OCMock/NSInvocation+OCMAdditions.h>

SpecBegin(TaskGatewaySpec)

describe (@"TaskGateway", ^{
    context(@"#initWithRequestManager", ^{
        AFHTTPRequestOperationManager* requestManager = [OCMockObject mockForClass:[AFHTTPRequestOperationManager class]];
        TaskGateway* gateway = [[TaskGateway alloc] initWithRequestManager:requestManager];
        
        it (@"sets the requestManager property", ^{
            expect([gateway requestManager]).to.equal(requestManager);
        });
    });
    
    context(@"#requestData", ^{
        __block id delegate;
        __block id requestManager;
        __block TaskGateway* gateway;
        
        beforeEach(^{
            delegate = [OCMockObject mockForProtocol:@protocol(GatewayResponseDelegate)];
            requestManager = [OCMockObject mockForClass:[AFHTTPRequestOperationManager class]];
            gateway = [[TaskGateway alloc] initWithRequestManager:requestManager];
        });
        
        it (@"calls GET on the request manager", ^{
            [[requestManager expect] GET:@"http://localhost:3000/tasks.json"
                              parameters:OCMOCK_ANY
                                 success:OCMOCK_ANY
                                 failure:OCMOCK_ANY];
            
            [gateway requestData:delegate];
            
            [requestManager verify];
        });
        
        it (@"invokes the delegate's onResponseSuccessful method if the request is successful", ^{
            [[delegate expect] onResponseSuccessful:OCMOCK_ANY];
            
            [[[requestManager expect] andDo:^(NSInvocation* invocation) {
                void (^success)(AFHTTPRequestOperation*, id*);
                success = [invocation getArgumentAtIndexAsObject:4];
                success(nil,nil);
            }] GET:OCMOCK_ANY parameters:OCMOCK_ANY success:OCMOCK_ANY failure:OCMOCK_ANY];
            
            [gateway requestData:delegate];
            
            [delegate verify];
        });
        
        it (@"invokes the delegate's onResponseError method if the request fails", ^{
            [[delegate expect] onResponseFailure:OCMOCK_ANY];
            
            [[[requestManager expect] andDo:^(NSInvocation* invocation) {
                void (^failure)(AFHTTPRequestOperation*, id*);
                failure = [invocation getArgumentAtIndexAsObject:5];
                failure(nil,nil);
            }] GET:OCMOCK_ANY parameters:OCMOCK_ANY success:OCMOCK_ANY failure:OCMOCK_ANY];
            
            [gateway requestData:delegate];
            
            [delegate verify];
        });
    });
});

SpecEnd
