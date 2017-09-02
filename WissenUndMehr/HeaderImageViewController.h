//
//  HeaderImageViewController.h
//  WissenUndMehr
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderImageViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *oHeaderImage;

- (void) _setupOrientationLandscapeConstraints;
- (void) _setupOrientationPortraitConstraints;
@end
