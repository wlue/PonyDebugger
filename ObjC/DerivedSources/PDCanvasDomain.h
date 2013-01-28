//
//  PDCanvasDomain.h
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

@class PDCanvasTraceLog;
@class PDCanvasResourceInfo;
@class PDCanvasResourceState;

@protocol PDCanvasCommandDelegate;

@interface PDCanvasDomain : PDDynamicDebuggerDomain 

@property (nonatomic, assign) id <PDCanvasCommandDelegate, PDCommandDelegate> delegate;

@end

@protocol PDCanvasCommandDelegate <PDCommandDelegate>
@optional

// Enables Canvas inspection.
- (void)domain:(PDCanvasDomain *)domain enableWithCallback:(void (^)(id error))callback;

// Disables Canvas inspection.
- (void)domain:(PDCanvasDomain *)domain disableWithCallback:(void (^)(id error))callback;
- (void)domain:(PDCanvasDomain *)domain dropTraceLogWithTraceLogId:(NSString *)traceLogId callback:(void (^)(id error))callback;

// Checks if there is any uninstrumented canvas in the inspected page.
- (void)domain:(PDCanvasDomain *)domain hasUninstrumentedCanvasesWithCallback:(void (^)(NSNumber *result, id error))callback;
- (void)domain:(PDCanvasDomain *)domain captureFrameWithCallback:(void (^)(NSString *traceLogId, id error))callback;
- (void)domain:(PDCanvasDomain *)domain startCapturingWithCallback:(void (^)(NSString *traceLogId, id error))callback;
- (void)domain:(PDCanvasDomain *)domain stopCapturingWithTraceLogId:(NSString *)traceLogId callback:(void (^)(id error))callback;
- (void)domain:(PDCanvasDomain *)domain getTraceLogWithTraceLogId:(NSString *)traceLogId startOffset:(NSNumber *)startOffset maxLength:(NSNumber *)maxLength callback:(void (^)(PDCanvasTraceLog *traceLog, id error))callback;
- (void)domain:(PDCanvasDomain *)domain replayTraceLogWithTraceLogId:(NSString *)traceLogId stepNo:(NSNumber *)stepNo callback:(void (^)(PDCanvasResourceState *resourceState, id error))callback;
- (void)domain:(PDCanvasDomain *)domain getResourceInfoWithResourceId:(NSString *)resourceId callback:(void (^)(PDCanvasResourceInfo *resourceInfo, id error))callback;
- (void)domain:(PDCanvasDomain *)domain getResourceStateWithTraceLogId:(NSString *)traceLogId resourceId:(NSString *)resourceId callback:(void (^)(PDCanvasResourceState *resourceState, id error))callback;

@end

@interface PDDebugger (PDCanvasDomain)

@property (nonatomic, readonly, strong) PDCanvasDomain *canvasDomain;

@end
