//
//  CallViewController.h
//  WissenUndMehr
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Navigation.h"
#import "HeaderImageViewController.h"

@interface CallViewController : HeaderImageViewController <UIActionSheetDelegate>

@property (nonatomic, strong) Navigation *navigationElement;

@end
