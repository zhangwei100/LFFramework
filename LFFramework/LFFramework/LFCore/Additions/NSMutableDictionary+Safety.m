//
//  NSMutableDictionary+Safety.m
//  LFFramework
//
//  Created by Wei Zhang on 10/20/14.
//  Copyright (c) 2014 Wei Zhang. All rights reserved.
//

#import "NSMutableDictionary+Safety.h"

@implementation NSMutableDictionary (Safety)

- (void)safetySetObject:(id)anObject forKey:(id)aKey {
    if (anObject != nil) {
        [self setObject:anObject forKey:aKey];
    }
}

@end
