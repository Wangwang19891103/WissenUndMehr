//
//  Annotation.m
//  SchülerhilfeMap
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import "Annotation.h"


@implementation Annotation


@synthesize location;
@synthesize coordinate;
@synthesize title;
@synthesize subtitle;



#pragma mark - Initializer

- (id) initWithLocation:(Location*) p_location {
    
    self = [super init];
    
    self.location = p_location;
    coordinate = CLLocationCoordinate2DMake(self.location.latitude, self.location.longitude);
    title = self.location.name;
    subtitle = [NSString stringWithFormat:@"%@ %@", self.location.strasse, self.location.hausnr];
    
    return self;
}


@end
