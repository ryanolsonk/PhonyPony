//
//  PPLobbyWebSocket.m
//  PhonyPony
//
//  Created by Ryan Olson on 4/9/15.
//  Copyright (c) 2015 PhonyPony. All rights reserved.
//

#import "PPLobbyWebSocket.h"
#import "PPGatewayServer.h"

@implementation PPLobbyWebSocket

+ (BOOL)canHandleURI:(NSString *)path
{
    return [path isEqual:@"/lobby"];
}

- (void)didOpen
{
    [super didOpen];

    [[PPGatewayServer sharedGatewayServer] addLobby:self];
}

- (void)didClose
{
    [super didClose];
    
    [[PPGatewayServer sharedGatewayServer] removeLobby:self];
}

@end
