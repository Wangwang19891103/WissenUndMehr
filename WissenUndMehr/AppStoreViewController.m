//
//  AppStoreViewController.m
//  WissenUndMehr
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import "AppStoreViewController.h"

@interface AppStoreViewController ()



@end

@implementation AppStoreViewController

@synthesize parameters = _parameters;
@synthesize activityIndicator;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (!_loaded) {
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.activityIndicator.center = self.view.center;
        [self.activityIndicator startAnimating];
        [self.view addSubview:self.activityIndicator];
    }
    
    if (self.parameters) {
        [self loadProductWithParameters:self.parameters completionBlock:^(BOOL success,NSError *error){
            if (success) {
                _loaded = YES;
            } else {
                NSLog(@"Error occured while loading App Store Link: %@",error.localizedDescription);
                [self presentFailureView];
            }
            if (self.activityIndicator.isAnimating) {
                [self.activityIndicator removeFromSuperview];
            }
        }];
    }
}

- (void) presentFailureView {
    UIView *failureView = [[UIView alloc] initWithFrame:self.view.frame];
    UILabel *errorMsg = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44.0f)];
    errorMsg.text = @"Fehler beim Laden des App Store.";
    [errorMsg sizeToFit];
    [failureView addSubview:errorMsg];
    errorMsg.center = self.view.center;
    
    [self.view addSubview:failureView];
}

-(BOOL) shouldAutorotate {
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
