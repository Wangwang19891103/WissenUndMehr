//
//  VoucherViewController.m
//  WissenUndMehr
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import "VoucherViewController.h"
#import "ActionWebViewViewController.h"

@interface VoucherViewController ()

@end

@implementation VoucherViewController

@synthesize navigation = _navigation;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if (self.navigation) {
        [self.oButton setTitle:[self.navigation.title uppercaseString] forState:UIControlStateNormal];
        [self.oButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    }

}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"openVoucher"]) {
        if (self.navigation &&
            self.navigation.document.fileName &&
            [self.navigation.document.fileName length] > 0) {
            ActionWebViewViewController *targetVC = segue.destinationViewController;
            targetVC.aDocument = self.navigation.document;
        }
    }
    
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
