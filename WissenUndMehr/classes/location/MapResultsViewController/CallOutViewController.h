//
//  CallOutViewController.h
//  WissenUndMehr
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Annotation.h"
#import "CalloutView.h"

@interface CallOutViewController : UIViewController

@property (nonatomic, strong) Annotation *annotation;

- (id) initWithAnnotation:(Annotation *)anAnnotation;
- (IBAction)callButtonPressed:(id)sender;
- (IBAction)routeButtonPressed:(id)sender;


@end
