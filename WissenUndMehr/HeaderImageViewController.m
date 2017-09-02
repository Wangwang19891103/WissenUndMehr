//
//  HeaderImageViewController.m
//  WissenUndMehr
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import "HeaderImageViewController.h"
#import "AppDelegate.h"

@interface HeaderImageViewController ()



@end

@implementation HeaderImageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        [self _setupOrientationLandscapeConstraints];
    } else {
        [self _setupOrientationPortraitConstraints];
    }
}

#pragma mark -. Handling rotation and orientation
-(void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        
        [self _setupOrientationLandscapeConstraints];
        
    } else {
        
        [self _setupOrientationPortraitConstraints];
    }
}

- (void) _setupOrientationLandscapeConstraints {
    
    //only perform this on ipad
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (!appDelegate.isDeviceIPad) {
        return;
    }
    
    [self.oHeaderImage setImage:[UIImage imageNamed:@"start_header-landscape"]];
    [self.oHeaderImage invalidateIntrinsicContentSize];
}

- (void) _setupOrientationPortraitConstraints {
    
    //only perform this on ipad
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (!appDelegate.isDeviceIPad) {
        return;
    }
    
    [self.oHeaderImage setImage:[UIImage imageNamed:@"start_header"]];
    [self.oHeaderImage invalidateIntrinsicContentSize];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
