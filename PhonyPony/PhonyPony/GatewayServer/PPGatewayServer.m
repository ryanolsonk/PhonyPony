//
//  PPGatewayServer.m
//  PhonyPony
//
//  Created by Ryan Olson on 4/9/15.
//  Copyright (c) 2015 PhonyPony. All rights reserved.
//

#import "PPGatewayServer.h"
#import "PPHTTPConnection.h"
#import "PPDeviceWebSocket.h"
#import "PPLobbyWebSocket.h"
#import "PPDevToolsWebSocket.h"
#import <CocoaHTTPServer/HTTPServer.h>

@interface PPGatewayServer ()

@property (nonatomic, strong) HTTPServer *server;

@property (nonatomic, assign) NSInteger currentPageNumber;
@property (nonatomic, assign) NSInteger lobbyMessageNumber;

@property (nonatomic, strong) NSMutableSet *lobbyWebSockets;
@property (nonatomic, strong) NSMutableSet *deviceWebSockets;
@property (nonatomic, strong) NSMutableSet *devToolsWebSockets;

@property (nonatomic, strong) dispatch_queue_t gatewayQueue;

@end

@implementation PPGatewayServer

+ (instancetype)sharedGatewayServer
{
    static PPGatewayServer *gatewayServer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gatewayServer = [[self class] new];
    });
    return gatewayServer;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.lobbyWebSockets = [NSMutableSet set];
        self.deviceWebSockets = [NSMutableSet set];
        self.devToolsWebSockets = [NSMutableSet set];

        self.gatewayQueue = dispatch_queue_create("com.phonypony.gateway", DISPATCH_QUEUE_SERIAL);

        self.server = [HTTPServer new];
        [self.server setConnectionClass:[PPHTTPConnection class]];
        [self.server setPort:9000];
        NSString *webRoot = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"web"];
        [self.server setDocumentRoot:webRoot];
    }
    return self;
}

- (void)start
{
    [self.server start:NULL];
}

#pragma mark - Device

- (void)registerDevice:(PPDeviceWebSocket *)device
{
    dispatch_async(self.gatewayQueue, ^{
        device.pageNumber = self.currentPageNumber;
        self.currentPageNumber++;
        [self.deviceWebSockets addObject:device];
        [self messageLobbiesWithMethod:@"Gateway.deviceAdded" parameters:device.deviceInfo];
    });
}

- (void)unregisterDevice:(PPDeviceWebSocket *)device
{
    dispatch_async(self.gatewayQueue, ^{
        [self.deviceWebSockets removeObject:device];
    });
}

#pragma mark - Lobbies

- (void)messageLobbiesWithMethod:(NSString *)method parameters:(NSDictionary *)parameters
{
    dispatch_async(self.gatewayQueue, ^{
        for (PPLobbyWebSocket *lobby in self.lobbyWebSockets) {
            [self messageLobby:lobby withMethod:method parameters:parameters];
        }
    });
}

- (void)messageLobby:(PPLobbyWebSocket *)lobby withMethod:(NSString *)method parameters:(NSDictionary *)parameters
{
    NSDictionary *payload = @{ @"id" : @(self.lobbyMessageNumber++), @"method" : method, @"params" : parameters };
    if ([NSJSONSerialization isValidJSONObject:payload]) {
        NSString *payloadString = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:payload options:0 error:NULL] encoding:NSUTF8StringEncoding];
        [lobby sendMessage:payloadString];
    }
}

- (void)addLobby:(PPLobbyWebSocket *)lobby
{
    dispatch_async(self.gatewayQueue, ^{
        [self.lobbyWebSockets addObject:lobby];

        for (PPDeviceWebSocket *device in self.deviceWebSockets) {
            [self messageLobby:lobby withMethod:@"Gateway.deviceAdded" parameters:device.deviceInfo];
        }
    });
}

- (void)removeLobby:(PPLobbyWebSocket *)lobby
{
    dispatch_async(self.gatewayQueue, ^{
        [self.lobbyWebSockets removeObject:lobby];
    });
}

#pragma mark - Dev Tools

- (void)devToolsDidConnect:(PPDevToolsWebSocket *)devTools
{
    dispatch_async(self.gatewayQueue, ^{
        [self.devToolsWebSockets addObject:devTools];

        for (PPDeviceWebSocket *device in self.deviceWebSockets) {
            if (device.pageNumber == devTools.pageNumber) {
                device.devTools = devTools;
                devTools.device = device;
                break;
            }
        }
    });
}

- (void)devToolsDidClose:(PPDevToolsWebSocket *)devTools
{
    dispatch_async(self.gatewayQueue, ^{
        [self.devToolsWebSockets removeObject:devTools];
    });
}

@end
