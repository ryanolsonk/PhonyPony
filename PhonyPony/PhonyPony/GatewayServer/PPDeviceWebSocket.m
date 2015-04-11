//
//  PPDeviceWebSocket.m
//  PhonyPony
//
//  Created by Ryan Olson on 4/9/15.
//  Copyright (c) 2015 PhonyPony. All rights reserved.
//

#import "PPDeviceWebSocket.h"
#import "PPDevToolsWebSocket.h"
#import "PPGatewayServer.h"

@interface PPDeviceWebSocket ()

@property (nonatomic, copy) NSString *connectionID;

@property (nonatomic, copy, readwrite) NSDictionary *deviceInfo;

@end

@implementation PPDeviceWebSocket

+ (BOOL)canHandleURI:(NSString *)path
{
    return [path isEqual:@"/device"];
}

- (void)didOpen
{
    [super didOpen];

    self.connectionID = [[NSUUID UUID] UUIDString];
}

- (void)didReceiveMessage:(NSString *)msg
{
    [super didReceiveMessage:msg];
    
    if (self.devTools) {
        [self.devTools sendMessage:msg];
    } else {
        id jsonObject = [NSJSONSerialization JSONObjectWithData:[msg dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL];
        if ([jsonObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dictionary = jsonObject;
            if ([[dictionary objectForKey:@"method"] isEqual:@"Gateway.registerDevice"]) {
                self.deviceInfo = [dictionary objectForKey:@"params"];
                [[PPGatewayServer sharedGatewayServer] registerDevice:self];
            }
        }
    }
}

- (void)didClose
{
    [super didClose];
    
    [[PPGatewayServer sharedGatewayServer] unregisterDevice:self];
}

- (NSDictionary *)deviceInfo
{
    NSMutableDictionary *deviceInfo = [_deviceInfo mutableCopy];
    [deviceInfo setObject:self.connectionID forKey:@"connection_id"];
    [deviceInfo setObject:@(self.pageNumber) forKey:@"page"];
    return [deviceInfo copy];
}

@end
