//
//  MainViewController.h
//  WissenUndMehr
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

@property (nonatomic, strong) UIManagedDocument *contentData;
@property (nonatomic, strong) NSArray *dataSource;

@property (weak, nonatomic) IBOutlet UIImageView *otitleImageView;
@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *oButtons;
@property (weak, nonatomic) IBOutlet UIScrollView *oScrollview;
@property (weak, nonatomic) IBOutlet UIView *oMainContainer;
@property (weak, nonatomic) IBOutlet UIButton *oBottomMostButton;
@property (weak, nonatomic) IBOutlet UIImageView *oBookImage;

@end
