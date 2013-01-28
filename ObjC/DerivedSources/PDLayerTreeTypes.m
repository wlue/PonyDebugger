//
//  PDLayerTreeTypes.m
//  PonyDebuggerDerivedSources
//
//  Generated on 1/28/13
//
//  Licensed to Square, Inc. under one or more contributor license agreements.
//  See the LICENSE file distributed with this work for the terms under
//  which Square, Inc. licenses this file to you.
//

#import "PDLayerTreeTypes.h"

@implementation PDLayerTreeIntRect

+ (NSDictionary *)keysToEncode;
{
    static NSDictionary *mappings = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mappings = [[NSDictionary alloc] initWithObjectsAndKeys:
                    @"x",@"x",
                    @"y",@"y",
                    @"width",@"width",
                    @"height",@"height",
                    nil];
    });

    return mappings;
}

@dynamic x;
@dynamic y;
@dynamic width;
@dynamic height;
 
@end

@implementation PDLayerTreeLayer

+ (NSDictionary *)keysToEncode;
{
    static NSDictionary *mappings = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mappings = [[NSDictionary alloc] initWithObjectsAndKeys:
                    @"layerId",@"layerId",
                    @"bounds",@"bounds",
                    @"isComposited",@"isComposited",
                    @"paintCount",@"paintCount",
                    @"memory",@"memory",
                    @"compositedBounds",@"compositedBounds",
                    @"childLayers",@"childLayers",
                    nil];
    });

    return mappings;
}

@dynamic layerId;
@dynamic bounds;
@dynamic isComposited;
@dynamic paintCount;
@dynamic memory;
@dynamic compositedBounds;
@dynamic childLayers;
 
@end

