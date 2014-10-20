//
//  NSDictionary+Safety.m
//  LFFramework
//
//  Created by Wei Zhang on 10/20/14.
//  Copyright (c) 2014 Wei Zhang. All rights reserved.
//

#import "NSDictionary+Safety.h"

@implementation NSDictionary (Safety)

- (id)safetyObjectForKey:(id)aKey {
    id object = [self objectForKey:aKey];
    if ([object isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return object;
}

@end
