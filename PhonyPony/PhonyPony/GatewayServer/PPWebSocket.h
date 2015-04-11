//
//  PPWebSocket.h
//  PhonyPony
//
//  Created by Ryan Olson on 4/9/15.
//  Copyright (c) 2015 PhonyPony. All rights reserved.
//

#import "WebSocket.h"

@class HTTPMessage;

@interface PPWebSocket : WebSocket

+ (BOOL)canHandleURI:(NSString *)path;

@end
