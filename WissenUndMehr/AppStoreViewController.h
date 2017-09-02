//
//  AppStoreViewController.h
//  WissenUndMehr
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

@interface AppStoreViewController : SKStoreProductViewController {
    BOOL _loaded;
}

@property (nonatomic, strong) NSDictionary *parameters;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end
