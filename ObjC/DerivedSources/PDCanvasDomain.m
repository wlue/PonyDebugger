//
//  PDCanvasDomain.m
//  PonyDebuggerDerivedSources
//
//  Generated on 1/28/13
//
//  Licensed to Square, Inc. under one or more contributor license agreements.
//  See the LICENSE file distributed with this work for the terms under
//  which Square, Inc. licenses this file to you.
//

#import <PonyDebugger/PDObject.h>
#import <PonyDebugger/PDCanvasDomain.h>
#import <PonyDebugger/PDObject.h>
#import <PonyDebugger/PDCanvasTypes.h>


@interface PDCanvasDomain ()
//Commands

@end

@implementation PDCanvasDomain

@dynamic delegate;

+ (NSString *)domainName;
{
    return @"Canvas";
}



- (void)handleMethodWithName:(NSString *)methodName parameters:(NSDictionary *)params responseCallback:(PDResponseCallback)responseCallback;
{
    if ([methodName isEqualToString:@"enable"] && [self.delegate respondsToSelector:@selector(domain:enableWithCallback:)]) {
        [self.delegate domain:self enableWithCallback:^(id error) {
            responseCallback(nil, error);
        }];
    } else if ([methodName isEqualToString:@"disable"] && [self.delegate respondsToSelector:@selector(domain:disableWithCallback:)]) {
        [self.delegate domain:self disableWithCallback:^(id error) {
            responseCallback(nil, error);
        }];
    } else if ([methodName isEqualToString:@"dropTraceLog"] && [self.delegate respondsToSelector:@selector(domain:dropTraceLogWithTraceLogId:callback:)]) {
        [self.delegate domain:self dropTraceLogWithTraceLogId:[params objectForKey:@"traceLogId"] callback:^(id error) {
            responseCallback(nil, error);
        }];
    } else if ([methodName isEqualToString:@"hasUninstrumentedCanvases"] && [self.delegate respondsToSelector:@selector(domain:hasUninstrumentedCanvasesWithCallback:)]) {
        [self.delegate domain:self hasUninstrumentedCanvasesWithCallback:^(NSNumber *result, id error) {
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:1];

            if (result != nil) {
                [params setObject:result forKey:@"result"];
            }

            responseCallback(params, error);
        }];
    } else if ([methodName isEqualToString:@"captureFrame"] && [self.delegate respondsToSelector:@selector(domain:captureFrameWithCallback:)]) {
        [self.delegate domain:self captureFrameWithCallback:^(NSString *traceLogId, id error) {
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:1];

            if (traceLogId != nil) {
                [params setObject:traceLogId forKey:@"traceLogId"];
            }

            responseCallback(params, error);
        }];
    } else if ([methodName isEqualToString:@"startCapturing"] && [self.delegate respondsToSelector:@selector(domain:startCapturingWithCallback:)]) {
        [self.delegate domain:self startCapturingWithCallback:^(NSString *traceLogId, id error) {
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:1];

            if (traceLogId != nil) {
                [params setObject:traceLogId forKey:@"traceLogId"];
            }

            responseCallback(params, error);
        }];
    } else if ([methodName isEqualToString:@"stopCapturing"] && [self.delegate respondsToSelector:@selector(domain:stopCapturingWithTraceLogId:callback:)]) {
        [self.delegate domain:self stopCapturingWithTraceLogId:[params objectForKey:@"traceLogId"] callback:^(id error) {
            responseCallback(nil, error);
        }];
    } else if ([methodName isEqualToString:@"getTraceLog"] && [self.delegate respondsToSelector:@selector(domain:getTraceLogWithTraceLogId:startOffset:maxLength:callback:)]) {
        [self.delegate domain:self getTraceLogWithTraceLogId:[params objectForKey:@"traceLogId"] startOffset:[params objectForKey:@"startOffset"] maxLength:[params objectForKey:@"maxLength"] callback:^(PDCanvasTraceLog *traceLog, id error) {
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:1];

            if (traceLog != nil) {
                [params setObject:traceLog forKey:@"traceLog"];
            }

            responseCallback(params, error);
        }];
    } else if ([methodName isEqualToString:@"replayTraceLog"] && [self.delegate respondsToSelector:@selector(domain:replayTraceLogWithTraceLogId:stepNo:callback:)]) {
        [self.delegate domain:self replayTraceLogWithTraceLogId:[params objectForKey:@"traceLogId"] stepNo:[params objectForKey:@"stepNo"] callback:^(PDCanvasResourceState *resourceState, id error) {
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:1];

            if (resourceState != nil) {
                [params setObject:resourceState forKey:@"resourceState"];
            }

            responseCallback(params, error);
        }];
    } else if ([methodName isEqualToString:@"getResourceInfo"] && [self.delegate respondsToSelector:@selector(domain:getResourceInfoWithResourceId:callback:)]) {
        [self.delegate domain:self getResourceInfoWithResourceId:[params objectForKey:@"resourceId"] callback:^(PDCanvasResourceInfo *resourceInfo, id error) {
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:1];

            if (resourceInfo != nil) {
                [params setObject:resourceInfo forKey:@"resourceInfo"];
            }

            responseCallback(params, error);
        }];
    } else if ([methodName isEqualToString:@"getResourceState"] && [self.delegate respondsToSelector:@selector(domain:getResourceStateWithTraceLogId:resourceId:callback:)]) {
        [self.delegate domain:self getResourceStateWithTraceLogId:[params objectForKey:@"traceLogId"] resourceId:[params objectForKey:@"resourceId"] callback:^(PDCanvasResourceState *resourceState, id error) {
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:1];

            if (resourceState != nil) {
                [params setObject:resourceState forKey:@"resourceState"];
            }

            responseCallback(params, error);
        }];
    } else {
        [super handleMethodWithName:methodName parameters:params responseCallback:responseCallback];
    }
}

@end


@implementation PDDebugger (PDCanvasDomain)

- (PDCanvasDomain *)canvasDomain;
{
    return [self domainForName:@"Canvas"];
}

@end
