//    
//  PDCanvasTypes.h
//  PonyDebuggerDerivedSources
//
//  Generated on 1/28/13
//
//  Licensed to Square, Inc. under one or more contributor license agreements.
//  See the LICENSE file distributed with this work for the terms under
//  which Square, Inc. licenses this file to you.
//
    
#import <PonyDebugger/PDObject.h>
#import <PonyDebugger/PDDebugger.h>
#import <PonyDebugger/PDDynamicDebuggerDomain.h>


@interface PDCanvasResourceInfo : PDObject

@property (nonatomic, strong) NSString *identifier;

// Type: string
@property (nonatomic, strong) NSString *objectDescription;

@end


@interface PDCanvasResourceState : PDObject

@property (nonatomic, strong) NSString *identifier;

@property (nonatomic, strong) NSString *traceLogId;

// Screenshot image data URL.
// Type: string
@property (nonatomic, strong) NSString *imageURL;

@end


@interface PDCanvasCallArgument : PDObject

// Type: string
@property (nonatomic, strong) NSString *objectDescription;

@end


@interface PDCanvasCall : PDObject

@property (nonatomic, strong) NSString *contextId;

// Type: string
@property (nonatomic, strong) NSString *functionName;

// Type: array
@property (nonatomic, strong) NSArray *arguments;

@property (nonatomic, strong) PDCanvasCallArgument *result;

// Type: boolean
@property (nonatomic, strong) NSNumber *isDrawingCall;

// Type: string
@property (nonatomic, strong) NSString *property;

@property (nonatomic, strong) PDCanvasCallArgument *value;

// Type: string
@property (nonatomic, strong) NSString *sourceURL;

// Type: integer
@property (nonatomic, strong) NSNumber *lineNumber;

// Type: integer
@property (nonatomic, strong) NSNumber *columnNumber;

@end


@interface PDCanvasTraceLog : PDObject

@property (nonatomic, strong) NSString *identifier;

// Type: array
@property (nonatomic, strong) NSArray *calls;

// Type: integer
@property (nonatomic, strong) NSNumber *startOffset;

// Type: boolean
@property (nonatomic, strong) NSNumber *alive;

// Type: number
@property (nonatomic, strong) NSNumber *totalAvailableCalls;

@end


