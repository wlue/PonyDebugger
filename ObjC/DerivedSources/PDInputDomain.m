//
//  PDInputDomain.m
//  PonyDebuggerDerivedSources
//
//  Generated on 1/28/13
//
//  Licensed to Square, Inc. under one or more contributor license agreements.
//  See the LICENSE file distributed with this work for the terms under
//  which Square, Inc. licenses this file to you.
//

#import <PonyDebugger/PDObject.h>
#import <PonyDebugger/PDInputDomain.h>
#import <PonyDebugger/PDObject.h>


@interface PDInputDomain ()
//Commands

@end

@implementation PDInputDomain

@dynamic delegate;

+ (NSString *)domainName;
{
    return @"Input";
}



- (void)handleMethodWithName:(NSString *)methodName parameters:(NSDictionary *)params responseCallback:(PDResponseCallback)responseCallback;
{
    if ([methodName isEqualToString:@"dispatchKeyEvent"] && [self.delegate respondsToSelector:@selector(domain:dispatchKeyEventWithType:modifiers:timestamp:text:unmodifiedText:keyIdentifier:windowsVirtualKeyCode:nativeVirtualKeyCode:macCharCode:autoRepeat:isKeypad:isSystemKey:callback:)]) {
        [self.delegate domain:self dispatchKeyEventWithType:[params objectForKey:@"type"] modifiers:[params objectForKey:@"modifiers"] timestamp:[params objectForKey:@"timestamp"] text:[params objectForKey:@"text"] unmodifiedText:[params objectForKey:@"unmodifiedText"] keyIdentifier:[params objectForKey:@"keyIdentifier"] windowsVirtualKeyCode:[params objectForKey:@"windowsVirtualKeyCode"] nativeVirtualKeyCode:[params objectForKey:@"nativeVirtualKeyCode"] macCharCode:[params objectForKey:@"macCharCode"] autoRepeat:[params objectForKey:@"autoRepeat"] isKeypad:[params objectForKey:@"isKeypad"] isSystemKey:[params objectForKey:@"isSystemKey"] callback:^(id error) {
            responseCallback(nil, error);
        }];
    } else if ([methodName isEqualToString:@"dispatchMouseEvent"] && [self.delegate respondsToSelector:@selector(domain:dispatchMouseEventWithType:x:y:modifiers:timestamp:button:clickCount:callback:)]) {
        [self.delegate domain:self dispatchMouseEventWithType:[params objectForKey:@"type"] x:[params objectForKey:@"x"] y:[params objectForKey:@"y"] modifiers:[params objectForKey:@"modifiers"] timestamp:[params objectForKey:@"timestamp"] button:[params objectForKey:@"button"] clickCount:[params objectForKey:@"clickCount"] callback:^(id error) {
            responseCallback(nil, error);
        }];
    } else {
        [super handleMethodWithName:methodName parameters:params responseCallback:responseCallback];
    }
}

@end


@implementation PDDebugger (PDInputDomain)

- (PDInputDomain *)inputDomain;
{
    return [self domainForName:@"Input"];
}

@end
