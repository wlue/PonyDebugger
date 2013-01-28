//
//  PDMemoryDomain.h
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

@class PDMemoryStringStatistics;
@class PDMemoryMemoryBlock;

@protocol PDMemoryCommandDelegate;

@interface PDMemoryDomain : PDDynamicDebuggerDomain 

@property (nonatomic, assign) id <PDMemoryCommandDelegate, PDCommandDelegate> delegate;

@end

@protocol PDMemoryCommandDelegate <PDCommandDelegate>
@optional
- (void)domain:(PDMemoryDomain *)domain getDOMNodeCountWithCallback:(void (^)(NSArray *domGroups, PDMemoryStringStatistics *strings, id error))callback;
// Param reportGraph: Whether native memory graph should be reported in addition to aggregated statistics.
// Callback Param distribution: An object describing all memory allocated by the process
// Callback Param graph: Native memory graph.
- (void)domain:(PDMemoryDomain *)domain getProcessMemoryDistributionWithReportGraph:(NSNumber *)reportGraph callback:(void (^)(PDMemoryMemoryBlock *distribution, NSDictionary *graph, id error))callback;

@end

@interface PDDebugger (PDMemoryDomain)

@property (nonatomic, readonly, strong) PDMemoryDomain *memoryDomain;

@end
