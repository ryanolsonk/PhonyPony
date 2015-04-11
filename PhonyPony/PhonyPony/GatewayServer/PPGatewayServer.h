//
//  PPGatewayServer.h
//  PhonyPony
//
//  Created by Ryan Olson on 4/9/15.
//  Copyright (c) 2015 PhonyPony. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PPDeviceWebSocket;
@class PPDevToolsWebSocket;
@class PPLobbyWebSocket;

@interface PPGatewayServer : NSObject

+ (instancetype)sharedGatewayServer;

- (void)start;

- (void)registerDevice:(PPDeviceWebSocket *)device;
- (void)unregisterDevice:(PPDeviceWebSocket *)device;

- (void)addLobby:(PPLobbyWebSocket *)lobby;
- (void)removeLobby:(PPLobbyWebSocket *)lobby;

- (void)devToolsDidConnect:(PPDevToolsWebSocket *)devTools;
- (void)devToolsDidClose:(PPDevToolsWebSocket *)devTools;

@end
