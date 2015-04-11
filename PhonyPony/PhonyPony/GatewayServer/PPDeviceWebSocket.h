//
//  PPDeviceWebSocket.h
//  PhonyPony
//
//  Created by Ryan Olson on 4/9/15.
//  Copyright (c) 2015 PhonyPony. All rights reserved.
//

#import "PPWebSocket.h"

@class PPDevToolsWebSocket;

@interface PPDeviceWebSocket : PPWebSocket

@property (nonatomic, assign) NSInteger pageNumber;
@property (nonatomic, copy, readonly) NSDictionary *deviceInfo;

@property (nonatomic, weak) PPDevToolsWebSocket *devTools;

@end
