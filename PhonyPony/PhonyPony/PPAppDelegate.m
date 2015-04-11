//
//  PPAppDelegate.m
//  PhonyPony
//
//  Created by Ryan Olson on 4/8/15.
//  Copyright (c) 2015 PhonyPony. All rights reserved.
//

#import "PPAppDelegate.h"
#import "PPGatewayServer.h"

@implementation PPAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[PPGatewayServer sharedGatewayServer] start];
    
    return YES;
}

@end
