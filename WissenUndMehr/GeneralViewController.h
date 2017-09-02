//
//  GeneralViewController.h
//  WissenUndMehr
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"
#import "Navigation.h"
#import <StoreKit/StoreKit.h>

@interface GeneralViewController : CoreDataTableViewController <SKStoreProductViewControllerDelegate>

@property (nonatomic, strong) NSArray *aDataSource;
@property (weak, nonatomic) IBOutlet UIView *oHeaderView;
- (IBAction)actionButtonPressed:(id)sender;

@end
