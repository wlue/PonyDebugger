//
//  PDLayerTreeDomain.m
//  PonyDebuggerDerivedSources
//
//  Generated on 1/28/13
//
//  Licensed to Square, Inc. under one or more contributor license agreements.
//  See the LICENSE file distributed with this work for the terms under
//  which Square, Inc. licenses this file to you.
//

#import <PonyDebugger/PDObject.h>
#import <PonyDebugger/PDLayerTreeDomain.h>
#import <PonyDebugger/PDObject.h>
#import <PonyDebugger/PDLayerTreeTypes.h>


@interface PDLayerTreeDomain ()
//Commands

@end

@implementation PDLayerTreeDomain

@dynamic delegate;

+ (NSString *)domainName;
{
    return @"LayerTree";
}

// Events
- (void)layerTreeDidChange;
{
    [self.debuggingServer sendEventWithName:@"LayerTree.layerTreeDidChange" parameters:nil];
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
    } else if ([methodName isEqualToString:@"getLayerTree"] && [self.delegate respondsToSelector:@selector(domain:getLayerTreeWithCallback:)]) {
        [self.delegate domain:self getLayerTreeWithCallback:^(PDLayerTreeLayer *layerTree, id error) {
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:1];

            if (layerTree != nil) {
                [params setObject:layerTree forKey:@"layerTree"];
            }

            responseCallback(params, error);
        }];
    } else if ([methodName isEqualToString:@"nodeIdForLayerId"] && [self.delegate respondsToSelector:@selector(domain:nodeIdForLayerIdWithLayerId:callback:)]) {
        [self.delegate domain:self nodeIdForLayerIdWithLayerId:[params objectForKey:@"layerId"] callback:^(NSNumber *nodeId, id error) {
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:1];

            if (nodeId != nil) {
                [params setObject:nodeId forKey:@"nodeId"];
            }

            responseCallback(params, error);
        }];
    } else {
        [super handleMethodWithName:methodName parameters:params responseCallback:responseCallback];
    }
}

@end


@implementation PDDebugger (PDLayerTreeDomain)

- (PDLayerTreeDomain *)layerTreeDomain;
{
    return [self domainForName:@"LayerTree"];
}

@end
