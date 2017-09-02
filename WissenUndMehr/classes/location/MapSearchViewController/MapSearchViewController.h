//
//  MapSearchViewController.h
//  SchülerhilfeMap
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "HeaderImageViewController.h"

@interface MapSearchViewController : HeaderImageViewController <UISearchBarDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *oSearchForUserLocationButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cVspaceBookImageToSearchBar;
@property (weak, nonatomic) IBOutlet UIScrollView *oScrollview;
@property (weak, nonatomic) IBOutlet UISearchBar *oSearchbar;

- (IBAction) actionSearchForUserLocation;
- (IBAction)searchbarButtonPressed:(id)sender;

@end
