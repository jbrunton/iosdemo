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

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

SpecBegin(TaskGatewaySpec)

describe (@"TaskGateway", ^{
    context(@"#initWithRequestManager", ^{
        AFHTTPRequestOperationManager* requestManager = mock([AFHTTPRequestOperationManager class]);
        TaskGateway* gateway = [[TaskGateway alloc] initWithRequestManager:requestManager];
        
        it (@"sets the requestManager property", ^{
            expect([gateway requestManager]).to.equal(requestManager);
        });
    });
    
    context(@"#requestData", ^{
        __block id delegate;
        __block AFHTTPRequestOperationManager* requestManager;
        __block TaskGateway* gateway;
        
        beforeEach(^{
            delegate = mockProtocol(@protocol(GatewayResponseDelegate));
            requestManager = mock([AFHTTPRequestOperationManager class]);
            gateway = [[TaskGateway alloc] initWithRequestManager:requestManager];
        });
        
        it (@"calls GET on the request manager", ^{
            [gateway requestData:delegate];
            
            [verify(requestManager) GET:@"http://localhost:3000/tasks.json"
                              parameters:anything()
                                 success:anything()
                                 failure:anything()];
            
        });
        
        it (@"invokes the delegate's onResponseSuccessful method if the request is successful", ^{
            [gateway requestData:delegate];
            
            MKTArgumentCaptor *argument = [[MKTArgumentCaptor alloc] init];
            [verify(requestManager) GET:anything()
                             parameters:anything()
                                success:[argument capture]
                                failure:anything()];
            
            void (^success)(AFHTTPRequestOperation*, id*) = [argument value];
            success(nil, nil);
            
            [verify(delegate) onResponseSuccessful:anything()];
        });
        
        it (@"invokes the delegate's onResponseError method if the request fails", ^{
            [gateway requestData:delegate];
            
            MKTArgumentCaptor *argument = [[MKTArgumentCaptor alloc] init];
            [verify(requestManager) GET:anything()
                             parameters:anything()
                                success:anything()
                                failure:[argument capture]];
            
            void (^failure)(AFHTTPRequestOperation*, id*) = [argument value];
            failure(nil, nil);
            
            [verify(delegate) onResponseFailure:anything()];
        });
    });
});

SpecEnd
