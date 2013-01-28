//
//  PDMemoryDomain.m
//  PonyDebuggerDerivedSources
//
//  Generated on 1/28/13
//
//  Licensed to Square, Inc. under one or more contributor license agreements.
//  See the LICENSE file distributed with this work for the terms under
//  which Square, Inc. licenses this file to you.
//

#import <PonyDebugger/PDObject.h>
#import <PonyDebugger/PDMemoryDomain.h>
#import <PonyDebugger/PDObject.h>
#import <PonyDebugger/PDMemoryTypes.h>


@interface PDMemoryDomain ()
//Commands

@end

@implementation PDMemoryDomain

@dynamic delegate;

+ (NSString *)domainName;
{
    return @"Memory";
}



- (void)handleMethodWithName:(NSString *)methodName parameters:(NSDictionary *)params responseCallback:(PDResponseCallback)responseCallback;
{
    if ([methodName isEqualToString:@"getDOMNodeCount"] && [self.delegate respondsToSelector:@selector(domain:getDOMNodeCountWithCallback:)]) {
        [self.delegate domain:self getDOMNodeCountWithCallback:^(NSArray *domGroups, PDMemoryStringStatistics *strings, id error) {
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:2];

            if (domGroups != nil) {
                [params setObject:domGroups forKey:@"domGroups"];
            }
            if (strings != nil) {
                [params setObject:strings forKey:@"strings"];
            }

            responseCallback(params, error);
        }];
    } else if ([methodName isEqualToString:@"getProcessMemoryDistribution"] && [self.delegate respondsToSelector:@selector(domain:getProcessMemoryDistributionWithReportGraph:callback:)]) {
        [self.delegate domain:self getProcessMemoryDistributionWithReportGraph:[params objectForKey:@"reportGraph"] callback:^(PDMemoryMemoryBlock *distribution, NSDictionary *graph, id error) {
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:2];

            if (distribution != nil) {
                [params setObject:distribution forKey:@"distribution"];
            }
            if (graph != nil) {
                [params setObject:graph forKey:@"graph"];
            }

            responseCallback(params, error);
        }];
    } else {
        [super handleMethodWithName:methodName parameters:params responseCallback:responseCallback];
    }
}

@end


@implementation PDDebugger (PDMemoryDomain)

- (PDMemoryDomain *)memoryDomain;
{
    return [self domainForName:@"Memory"];
}

@end
