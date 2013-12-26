//
//  DataSource.h
//  iosdemo
//
//  Created by John Brunton on 25/12/2013.
//  Copyright (c) 2013 John Brunton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataSource : NSObject <UITableViewDelegate, UITableViewDataSource>

- (void)setData:(NSArray*)data;
- (NSArray*)getData;
- (id)itemAt:(NSIndexPath*)indexPath;

@end
