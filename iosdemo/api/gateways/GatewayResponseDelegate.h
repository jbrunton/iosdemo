//
//  GatewayResponseDelegate.h
//  iosdemo
//
//  Created by John Brunton on 21/12/2013.
//  Copyright (c) 2013 John Brunton. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GatewayResponseDelegate <NSObject>
@required
- (void)onResponseSuccessful:(id)result;
- (void)onResponseFailure:(NSError*)error;
@end
