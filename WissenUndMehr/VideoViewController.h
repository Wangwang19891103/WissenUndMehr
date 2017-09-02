//
//  VideoViewController.h
//  WissenUndMehr
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Video.h"


@interface VideoViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *oContainerView;
@property (weak, nonatomic) IBOutlet UIWebView *oWebView;

@property (strong, nonatomic) Video *video;

@end
