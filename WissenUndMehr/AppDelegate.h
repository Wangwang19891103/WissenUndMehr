//
//  AppDelegate.h
//  WissenUndMehr

//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    
}

@property (strong, nonatomic) UIWindow *window;

- (BOOL) isDeviceIPad;

- (void)setEULAAccepted;
- (BOOL)isEULAAccepted;

@end
