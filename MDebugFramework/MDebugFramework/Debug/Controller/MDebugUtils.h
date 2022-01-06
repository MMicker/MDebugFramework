//
//  MDebugUtils.h
//  MDebugFramework
//
//  Created by Micker on 2022/1/6.
//  Copyright © 2022 micker. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MDebugUtils : NSObject

+ (NSArray *) makeJsonArray: (NSArray *) array;

+ (NSDictionary *) makeJsonDictionary:(NSDictionary *) dictionary;

@end

