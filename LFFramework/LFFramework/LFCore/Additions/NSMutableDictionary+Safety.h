//
//  NSMutableDictionary+Safety.h
//  LFFramework
//
//  Created by Wei Zhang on 10/20/14.
//  Copyright (c) 2014 Wei Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (Safety)

- (void)safetySetObject:(id)anObject forKey:(id)aKey;

@end
