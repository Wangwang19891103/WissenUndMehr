//
//  Annotation.h
//  SchülerhilfeMap
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Location.h"


@interface Annotation : NSObject <MKAnnotation>


@property (nonatomic, strong) Location* location;

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@property (nonatomic, readonly, copy) NSString* title;

@property (nonatomic, readonly, copy) NSString* subtitle;


- (id) initWithLocation:(Location*) p_location;


@end
