//
//  AnnotationView.h
//  SchülerhilfeMap
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "CallOutViewController.h"

@interface AnnotationView : MKAnnotationView

@property (nonatomic, strong) CallOutViewController *calloutViewController;
- (id) initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier isUserLocation:(BOOL) isUserLocation;


+ (CGSize) preferredSize;

@end
