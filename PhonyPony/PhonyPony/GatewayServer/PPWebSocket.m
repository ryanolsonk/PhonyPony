//
//  PPWebSocket.m
//  PhonyPony
//
//  Created by Ryan Olson on 4/9/15.
//  Copyright (c) 2015 PhonyPony. All rights reserved.
//

#import "PPWebSocket.h"
#import <CocoaAsyncSocket/GCDAsyncSocket.h>

@implementation PPWebSocket

- (void)socket:(GCDAsyncSocket *)socket didConnectToHost:(NSString *)host port:(uint16_t)port
{
    [socket performBlock:^{
        [socket enableBackgroundingOnSocket];
    }];
}

+ (BOOL)canHandleURI:(NSString *)path
{
    return NO;
}

@end
