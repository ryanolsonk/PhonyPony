//
//  PPDevToolsWebSocket.h
//  PhonyPony
//
//  Created by Ryan Olson on 4/9/15.
//  Copyright (c) 2015 PhonyPony. All rights reserved.
//

#import "PPWebSocket.h"

@class PPDeviceWebSocket;

@interface PPDevToolsWebSocket : PPWebSocket

@property (nonatomic, assign) NSInteger pageNumber;

@property (nonatomic, weak) PPDeviceWebSocket *device;

@end
