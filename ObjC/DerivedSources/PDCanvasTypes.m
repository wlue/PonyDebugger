//
//  PDCanvasTypes.m
//  PonyDebuggerDerivedSources
//
//  Generated on 1/28/13
//
//  Licensed to Square, Inc. under one or more contributor license agreements.
//  See the LICENSE file distributed with this work for the terms under
//  which Square, Inc. licenses this file to you.
//

#import "PDCanvasTypes.h"

@implementation PDCanvasResourceInfo

+ (NSDictionary *)keysToEncode;
{
    static NSDictionary *mappings = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mappings = [[NSDictionary alloc] initWithObjectsAndKeys:
                    @"id",@"identifier",
                    @"description",@"objectDescription",
                    nil];
    });

    return mappings;
}

@dynamic identifier;
@dynamic objectDescription;
 
@end

@implementation PDCanvasResourceState

+ (NSDictionary *)keysToEncode;
{
    static NSDictionary *mappings = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mappings = [[NSDictionary alloc] initWithObjectsAndKeys:
                    @"id",@"identifier",
                    @"traceLogId",@"traceLogId",
                    @"imageURL",@"imageURL",
                    nil];
    });

    return mappings;
}

@dynamic identifier;
@dynamic traceLogId;
@dynamic imageURL;
 
@end

@implementation PDCanvasCallArgument

+ (NSDictionary *)keysToEncode;
{
    static NSDictionary *mappings = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mappings = [[NSDictionary alloc] initWithObjectsAndKeys:
                    @"description",@"objectDescription",
                    nil];
    });

    return mappings;
}

@dynamic objectDescription;
 
@end

@implementation PDCanvasCall

+ (NSDictionary *)keysToEncode;
{
    static NSDictionary *mappings = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mappings = [[NSDictionary alloc] initWithObjectsAndKeys:
                    @"contextId",@"contextId",
                    @"functionName",@"functionName",
                    @"arguments",@"arguments",
                    @"result",@"result",
                    @"isDrawingCall",@"isDrawingCall",
                    @"property",@"property",
                    @"value",@"value",
                    @"sourceURL",@"sourceURL",
                    @"lineNumber",@"lineNumber",
                    @"columnNumber",@"columnNumber",
                    nil];
    });

    return mappings;
}

@dynamic contextId;
@dynamic functionName;
@dynamic arguments;
@dynamic result;
@dynamic isDrawingCall;
@dynamic property;
@dynamic value;
@dynamic sourceURL;
@dynamic lineNumber;
@dynamic columnNumber;
 
@end

@implementation PDCanvasTraceLog

+ (NSDictionary *)keysToEncode;
{
    static NSDictionary *mappings = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mappings = [[NSDictionary alloc] initWithObjectsAndKeys:
                    @"id",@"identifier",
                    @"calls",@"calls",
                    @"startOffset",@"startOffset",
                    @"alive",@"alive",
                    @"totalAvailableCalls",@"totalAvailableCalls",
                    nil];
    });

    return mappings;
}

@dynamic identifier;
@dynamic calls;
@dynamic startOffset;
@dynamic alive;
@dynamic totalAvailableCalls;
 
@end

