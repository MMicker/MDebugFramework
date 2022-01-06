//
//  MDebugUtils.m
//  MDebugFramework
//
//  Created by Micker on 2022/1/6.
//  Copyright © 2022 micker. All rights reserved.
//

#import "MDebugUtils.h"

@implementation MDebugUtils

+ (NSArray *) makeJsonArray: (NSArray *) array {
    NSMutableArray *result = [NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
        if([obj isKindOfClass: [NSDictionary class]]) {
            [result addObject: [self makeJsonDictionary:obj] ];
        } else if([obj isKindOfClass: [NSArray class]]) {
            [result addObject: [self makeJsonArray:obj]];
        } else if ([obj isKindOfClass: [NSString class]] || [obj isKindOfClass: [NSNumber class]]) {
            
            [result addObject:obj];
        } else {
            [result addObject:[NSString stringWithFormat:@"%@", [obj class]]];
        }
    }];
    
    return result;
}

+ (NSDictionary *) makeJsonDictionary:(NSDictionary *) dictionary {
    __block NSMutableDictionary *data = [NSMutableDictionary dictionary];
    if (dictionary && ![NSJSONSerialization isValidJSONObject:dictionary]) {
        [dictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if([obj isKindOfClass: [NSDictionary class]]) {
                [data setValue:[self makeJsonDictionary:obj] forKey:key];
            } else if([obj isKindOfClass: [NSArray class]]) {
                [data setValue:[self makeJsonArray:obj] forKey:key];
            } else if ([obj isKindOfClass: [NSString class]] || [obj isKindOfClass: [NSNumber class]]) {
                [data setValue:obj forKey:key];
            } else {
                [data setValue:[NSString stringWithFormat:@"%@", [obj class]] forKey:key];
            }
        }];
        return data;
    }
    return dictionary;
}

@end
