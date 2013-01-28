//
//  PDLayerTreeDomain.h
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

@class PDLayerTreeLayer;

@protocol PDLayerTreeCommandDelegate;

@interface PDLayerTreeDomain : PDDynamicDebuggerDomain 

@property (nonatomic, assign) id <PDLayerTreeCommandDelegate, PDCommandDelegate> delegate;

// Events
- (void)layerTreeDidChange;

@end

@protocol PDLayerTreeCommandDelegate <PDCommandDelegate>
@optional

// Enables compositing tree inspection.
- (void)domain:(PDLayerTreeDomain *)domain enableWithCallback:(void (^)(id error))callback;

// Disables compositing tree inspection.
- (void)domain:(PDLayerTreeDomain *)domain disableWithCallback:(void (^)(id error))callback;

// Returns the layer tree structure of the current page.
// Callback Param layerTree: Layer tree structure of the current page.
- (void)domain:(PDLayerTreeDomain *)domain getLayerTreeWithCallback:(void (^)(PDLayerTreeLayer *layerTree, id error))callback;

// Returns the node id for a given layer id.
// Callback Param nodeId: The node id for the given layer id.
- (void)domain:(PDLayerTreeDomain *)domain nodeIdForLayerIdWithLayerId:(NSString *)layerId callback:(void (^)(NSNumber *nodeId, id error))callback;

@end

@interface PDDebugger (PDLayerTreeDomain)

@property (nonatomic, readonly, strong) PDLayerTreeDomain *layerTreeDomain;

@end
