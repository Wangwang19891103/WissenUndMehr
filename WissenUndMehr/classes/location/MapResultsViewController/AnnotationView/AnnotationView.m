//
//  AnnotationView.m
//  SchülerhilfeMap
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import "AnnotationView.h"
#import "Annotation.h"
#import "CalloutView.h"


#define IMAGE_NAME              @"annotation_img"
#define IMAGE_NAME_USER         @"annotation_user"


@implementation AnnotationView

@synthesize calloutViewController = _calloutViewController;

#pragma mark - Initializer

- (id) initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier isUserLocation:(BOOL) isUserLocation {
    
    if (isUserLocation) {
        return nil;
    }
    
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    self.image = [UIImage imageNamed:(isUserLocation) ? IMAGE_NAME_USER : IMAGE_NAME]; assert(self.image);
    [self setFrame:CGRectMake(0, 0, self.image.size.width, self.image.size.height)];


    // Hier den Offset für die Annotation entsprechend dem Image setzen
    
//    self.centerOffset = CGPointMake(-self.image.size.width * 0.5, -self.image.size.height * 0.5);
    
    self.canShowCallout = false;

    
    return self;
}

/*! View Controller providing our call out view (lazy loading)
 */
- (CallOutViewController *) calloutViewController {
    
    if (_calloutViewController == nil) {
        _calloutViewController = [[CallOutViewController alloc] initWithAnnotation:(Annotation *)self.annotation];
    }
    
    return _calloutViewController;
}

- (void) setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    UIView *calloutView = self.calloutViewController.view;
    
    if (selected) {
        
        CGRect annotationViewBounds = self.bounds;
        CGRect calloutViewFrame = calloutView.frame;
        calloutViewFrame.origin.x = -(calloutViewFrame.size.width - annotationViewBounds.size.width) * 0.5;
        calloutViewFrame.origin.y = -(calloutViewFrame.size.height + 10.0);
        calloutView.frame = calloutViewFrame;
        
        [self addSubview:calloutView];
    } else {
        [calloutView removeFromSuperview];
    }
    
}

- (UIView *) hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitView = [super hitTest:point withEvent:event];
    
    if (hitView == nil && self.selected) {
        //we get the callout view from our viewcontroller
        CalloutView *calloutview = (CalloutView *)self.calloutViewController.view;
        
        //the initial point we get is relative to the annotation view (the pin), so
        //we need to convert the point from our relative position to a position that
        //lies in the coordinate system of the callout view
        CGPoint pointInAnnotaionView = [calloutview convertPoint:point fromView:self];
        hitView = [calloutview hitTest:pointInAnnotaionView withEvent:event];
    }
    
    return hitView;
}

+ (CGSize) preferredSize {
    
    static CGSize __size;
    if (CGSizeEqualToSize(__size, CGSizeZero)) [[UIImage imageNamed:IMAGE_NAME] size];
    return __size;
}

@end
