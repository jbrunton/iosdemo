//
//  TaskGateway.h
//  iosdemo
//
//  Created by John Brunton on 21/12/2013.
//  Copyright (c) 2013 John Brunton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GatewayResponseDelegate.h"

@interface TaskGateway : NSObject

- (void)requestData:(id <GatewayResponseDelegate>)delegate;

@end