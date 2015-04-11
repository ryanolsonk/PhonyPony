//
//  PPAppDelegate.m
//  PhonyPony
//
//  Created by Ryan Olson on 4/8/15.
//  Copyright (c) 2015 PhonyPony. All rights reserved.
//

#import "PPAppDelegate.h"
#import "PPGatewayServer.h"
#import <SVWebViewController/SVWebViewController.h>

@implementation PPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[PPGatewayServer sharedGatewayServer] start];

    SVWebViewController *webViewController = [[SVWebViewController alloc] initWithAddress:@"http://localhost:9000"];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:webViewController];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
