//    
//  PDLayerTreeTypes.h
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


// A rectangle.
@interface PDLayerTreeIntRect : PDObject

// The x position.
// Type: integer
@property (nonatomic, strong) NSNumber *x;

// The y position.
// Type: integer
@property (nonatomic, strong) NSNumber *y;

// The width metric.
// Type: integer
@property (nonatomic, strong) NSNumber *width;

// The height metric.
// Type: integer
@property (nonatomic, strong) NSNumber *height;

@end


// Information about a compositing layer.
@interface PDLayerTreeLayer : PDObject

// The unique id for this layer.
@property (nonatomic, strong) NSString *layerId;

// Bounds of the layer.
@property (nonatomic, strong) PDLayerTreeIntRect *bounds;

// Indicates whether this layer is composited.
// Type: boolean
@property (nonatomic, strong) NSNumber *isComposited;

// Indicates how many time this layer has painted.
// Type: integer
@property (nonatomic, strong) NSNumber *paintCount;

// Estimated memory used by this layer.
// Type: integer
@property (nonatomic, strong) NSNumber *memory;

// The bounds of the composited layer.
@property (nonatomic, strong) PDLayerTreeIntRect *compositedBounds;

// Child layers.
// Type: array
@property (nonatomic, strong) NSArray *childLayers;

@end


