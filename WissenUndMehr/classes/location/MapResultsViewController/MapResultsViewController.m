//
//  MapResultsViewController.m
//  SchülerhilfeMap
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import "MapResultsViewController.h"
#import "LocationManager.h"
#import "Annotation.h"
#import "Location.h"
#import "AnnotationView.h"



//#define MAP_EDGE_INSETS            UIEdgeInsetsMake(20,20,20,20)

@implementation MapResultsViewController

@synthesize oMapView;
@synthesize locations = _locations;


#pragma mark - View

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"Nachhilfe vor Ort";

    NSArray* annotations = [self createAnnotationsFromLocations:_locations];
    [self.oMapView addAnnotations:annotations];
    
    //new on iOS 7
    [self.oMapView showAnnotations:annotations animated:NO];
    
//    [self.mapView setVisibleMapRect:[self rectToFitAnnotations:annotations] edgePadding:MAP_EDGE_INSETS animated:true];
}



#pragma mark - Private

- (NSArray*) createAnnotationsFromLocations:(NSArray*) locations {
    
    NSMutableArray* annotations = [NSMutableArray array];
    
    for (Location* location in locations) {
        
        Annotation* newAnnotation = [[Annotation alloc] initWithLocation:location];
        [annotations addObject:newAnnotation];
    }
    
    return annotations;
}


//- (MKMapRect) rectToFitAnnotations:(NSArray*) annotations {
//    
//    MKMapRect rect = MKMapRectNull;
//    
//    for (id <MKAnnotation> annotation in annotations) {
//        
//        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
//        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
//        rect = MKMapRectUnion(rect, pointRect);
//    }
//    
//    return rect;
//}


- (void) bringCalloutToFront {
    
//    if (_calloutAnnotationView) {
//        
//        [_calloutAnnotationView.superview bringSubviewToFront:_calloutAnnotationView];
//    }
}



#pragma mark - Actions

- (IBAction) actionOpenInMaps {
    
    NSArray* mapItems = [[LocationManager instance] mapItemsFromLocations:_locations];
    [MKMapItem openMapsWithItems:mapItems launchOptions:nil];
}



#pragma mark - Delegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    NSString *reuseIdentifier = @"Schuelerhilfe Place";
    BOOL isUserLocation = [annotation isKindOfClass:[MKUserLocation class]];
    
    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:reuseIdentifier];
    
    if (!annotationView) {
        annotationView = [[AnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIdentifier isUserLocation:isUserLocation];
    } else {
        annotationView.annotation = annotation;
    }
    
//    
//    if ([annotation isKindOfClass:[CalloutAnnotation class]]) {
//        
//        CalloutAnnotationView* calloutAnnotationView = [[CalloutAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
//        _calloutAnnotationView = calloutAnnotationView;
//        return calloutAnnotationView;
//    }
//    else {

    
    return annotationView;
//    }
}




//- (void) mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
//    
//    NSLog(@"didSelectAnnotation");
//    
//    if ([view.annotation isKindOfClass:[MKUserLocation class]])
//        return;
//    else if ([view.annotation isKindOfClass:[CalloutAnnotationView class]]) {
//        return;
//    }
//    else if (view.annotation == _selectedAnnotation) {
//
//        [self.oMapView deselectAnnotation:_selectedAnnotation animated:true];
//        
//        return;
//    }
//    
//    _selectedAnnotation = view.annotation;
//    
//    Annotation* annotation = (Annotation*)view.annotation;
//    CalloutAnnotation* calloutAnnotation = [[CalloutAnnotation alloc] initWithLocation:annotation.location];
//    _calloutAnnotation = calloutAnnotation;
//    
//    [self.oMapView addAnnotation:calloutAnnotation];
//}
//
//
//- (void) mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
//    
//    NSLog(@"didDeselectAnnotation");
//
//    [self.oMapView removeAnnotation:_calloutAnnotation];
//    _calloutAnnotation = nil;
//    _selectedAnnotation = nil;
//    _calloutAnnotationView = nil;
//}


- (void) mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    
    [self bringCalloutToFront];
}


- (void) mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    
    [self bringCalloutToFront];
}



@end
