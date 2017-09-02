//
//  PocketGuideViewController.h
//  WissenUndMehr
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderImageViewController.h"

@interface PocketGuideViewController : HeaderImageViewController

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSString *aTitle;

@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *oButtons;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *oButtonTitles;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *oButtonSubtitles;


@end
