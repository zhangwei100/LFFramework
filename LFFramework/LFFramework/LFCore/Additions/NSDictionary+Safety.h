//
//  NSDictionary+Safety.h
//  LFFramework
//
//  Created by Wei Zhang on 10/20/14.
//  Copyright (c) 2014 Wei Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Safety)

- (id)safetyObjectForKey:(id)aKey;

@end
