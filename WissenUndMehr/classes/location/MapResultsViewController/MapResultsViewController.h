//
//  MapResultsViewController.h
//  SchülerhilfeMap
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "AnnotationView.h"
#import "CallOutViewController.h"

@interface MapResultsViewController : UIViewController <MKMapViewDelegate> {
    
    NSArray* _locations;
    
//    CalloutAnnotation* __weak _calloutAnnotation;
//    CalloutAnnotationView* __weak _calloutAnnotationView;
    
    MKAnnotationView* __weak _userAnnotationView;
    
    Annotation* __weak _selectedAnnotation;
}


@property (nonatomic, strong) IBOutlet MKMapView* oMapView;
@property (nonatomic, strong) NSArray *locations;



- (IBAction) actionOpenInMaps;

@end
