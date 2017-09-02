//
//  AppDelegate.m
//  WissenUndMehr
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import <MediaPlayer/MediaPlayer.h>

#ifdef EULA
#import "EULAViewController.h"
#endif

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
//    UINavigationController *navigationController = (UINavigationController*) self.window.rootViewController;
//    MainViewController *initialVC = [[navigationController viewControllers] objectAtIndex:0];


    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
#ifdef EULA
    if (![self isEULAAccepted] && !self.window.rootViewController.presentedViewController) {
        EULAViewController *eulaCnt = [EULAViewController new];
        NSString *sPath = [[NSBundle mainBundle] pathForResource:@"Datenschutzerklärung-SH" ofType:@"pdf"];
        eulaCnt.pdfFile = sPath;
        
        __weak typeof(self) weakSelf = self;
        [eulaCnt setAcceptActionBlock:^{
            [weakSelf setEULAAccepted];
        }];
        
        [self.window.rootViewController presentViewController:[[UINavigationController alloc] initWithRootViewController:eulaCnt] animated:NO completion:nil];
    }
#endif
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark -- Helper Methods
- (BOOL) isDeviceIPad {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 30200
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return YES;
    }
#endif
    return NO;
}

- (void)setEULAAccepted
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"EULA"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)isEULAAccepted
{
    BOOL result = [[NSUserDefaults standardUserDefaults] boolForKey:@"EULA"];
    if (!result) {
        return NO;
    }
    return result;
}

@end
