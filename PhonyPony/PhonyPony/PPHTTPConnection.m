//
//  PPHTTPConnection.m
//  PhonyPony
//
//  Created by Ryan Olson on 4/9/15.
//  Copyright (c) 2015 PhonyPony. All rights reserved.
//

#import "PPHTTPConnection.h"
#import "PPDevToolsWebSocket.h"
#import "PPLobbyWebSocket.h"
#import "PPDeviceWebSocket.h"
#import <CocoaAsyncSocket/GCDAsyncSocket.h>

@implementation PPHTTPConnection

- (WebSocket *)webSocketForURI:(NSString *)path
{
    WebSocket *webSocket = nil;

    if ([PPDevToolsWebSocket canHandleURI:path]) {
        webSocket = [[PPDevToolsWebSocket alloc] initWithRequest:request socket:asyncSocket];
    } else if([PPLobbyWebSocket canHandleURI:path]) {
        webSocket = [[PPLobbyWebSocket alloc] initWithRequest:request socket:asyncSocket];
    } else if ([PPDeviceWebSocket canHandleURI:path]) {
        webSocket = [[PPDeviceWebSocket alloc] initWithRequest:request socket:asyncSocket];
    }

    return webSocket;
}

- (void)socket:(GCDAsyncSocket *)socket didConnectToHost:(NSString *)host port:(uint16_t)port
{
    [socket performBlock:^{
        [socket enableBackgroundingOnSocket];
    }];
}

@end
