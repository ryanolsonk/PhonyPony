//
//  PPDevToolsWebSocket.m
//  PhonyPony
//
//  Created by Ryan Olson on 4/9/15.
//  Copyright (c) 2015 PhonyPony. All rights reserved.
//

#import "PPDevToolsWebSocket.h"
#import "PPDeviceWebSocket.h"
#import "PPGatewayServer.h"
#import <CocoaHTTPServer/HTTPMessage.h>

@implementation PPDevToolsWebSocket

+ (BOOL)canHandleURI:(NSString *)path
{
    return [[self pageStringFromDevToolsPath:path] length] > 0;
}

+ (NSString *)pageStringFromDevToolsPath:(NSString *)path
{
    NSString *pageString = nil;

    NSRegularExpression *devtoolsPageRegex = [NSRegularExpression regularExpressionWithPattern:@"/devtools/page/([0-9]*)/?" options:0 error:NULL];
    NSArray *matches = [devtoolsPageRegex matchesInString:path options:0 range:NSMakeRange(0, [path length])];
    if ([matches count] > 0) {
        NSTextCheckingResult *result = [matches firstObject];
        pageString = [path substringWithRange:[result rangeAtIndex:1]];
    }

    return pageString;
}

- (void)didOpen
{
    [super didOpen];

    NSString *path = [[request url] relativeString];
    NSString *page = [[self class] pageStringFromDevToolsPath:path];
    self.pageNumber = [page integerValue];
    [[PPGatewayServer sharedGatewayServer] devToolsDidConnect:self];
}

- (void)didReceiveMessage:(NSString *)msg
{
    [super didReceiveMessage:msg];

    [self.device sendMessage:msg];
}

- (void)didClose
{
    [super didClose];
    
    [[PPGatewayServer sharedGatewayServer] devToolsDidClose:self];
}

@end
