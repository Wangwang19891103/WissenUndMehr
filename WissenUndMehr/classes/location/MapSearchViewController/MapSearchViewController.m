//
//  MapSearchViewController.m
//  SchülerhilfeMap
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import "MapSearchViewController.h"
#import "LocationManager.h"
#import "MapResultsViewController.h"
#import "AppDelegate.h"


#define INITIAL_RADIUS          30000  // 30km
#define RADIUS_INCREMENT        5000 // 5km
#define MINIMUM_RESULTS         5
#define MAXIMUM_RADIUS          200000  // 200km

#define ALERT_TITLE                             @"Suche"
#define MESSAGE_ERROR_GEOCODER_NO_RESULT        @"Es wurden keine Ergebnisse gefunden."
#define MESSAGE_ERROR_GEOCODER_GENERAL          @"Allgemeiner Fehler."
#define MESSAGE_ERROR_LOCATION_MANAGER          @"Bitte aktivieren Sie den Ortungsservice zur Nutzung dieser Funktion."

@interface MapSearchViewController ()

@property (nonatomic, assign, getter=isRetrievingPending) BOOL retrievePending;
@property (nonatomic, strong) NSArray *results;
@property (nonatomic, strong) CLLocationManager* locationManager;

@end


@implementation MapSearchViewController


#pragma mark - View

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"Suche";
    
    UITapGestureRecognizer* recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionContentTap:)];
    [self.view addGestureRecognizer:recognizer];
    
    [self.oSearchForUserLocationButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self registerForKeyboardNotifications];
}

- (void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) _setupOrientationLandscapeConstraints {
    [super _setupOrientationLandscapeConstraints];
    
    self.cVspaceBookImageToSearchBar.constant = 0.0f;
}

- (void) _setupOrientationPortraitConstraints {
    
    [super _setupOrientationPortraitConstraints];
    
    self.cVspaceBookImageToSearchBar.constant = -276.0f;
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    kbRect = [self.view convertRect:kbRect fromView:nil];
    
    CGSize kbSize = kbRect.size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height + 30.0f, 0.0);
    self.oScrollview.contentInset = contentInsets;
    self.oScrollview.scrollIndicatorInsets = contentInsets;
    
//    // If active text field is hidden by keyboard, scroll it so it's visible
//    // Your app might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, self.oSearchbar.frame.origin) ) {
        [self.oScrollview scrollRectToVisible:self.oSearchbar.frame animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.oScrollview.contentInset = contentInsets;
    self.oScrollview.scrollIndicatorInsets = contentInsets;
}

#pragma mark - Actions

- (IBAction) actionSearchForUserLocation {
    
    [self.view endEditing:YES];

    CLAuthorizationStatus authStatus = [CLLocationManager authorizationStatus];
    
    switch (authStatus) {
        case kCLAuthorizationStatusAuthorized:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        {
            //we go on
            [self setupLocationManager];
            [self performSearchForUserLocation];
            break;
        }
        case kCLAuthorizationStatusDenied:
            [self handleUnauthorizedState];
            break;
        case kCLAuthorizationStatusNotDetermined:
        {
            //ask for permission
            [self setupLocationManager];
            [self.locationManager requestWhenInUseAuthorization];
            break;
        }
        case kCLAuthorizationStatusRestricted:
            [self handleUnauthorizedState];
            break;
        default:
            break;
    }
}

- (void) handleUnauthorizedState
{
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:ALERT_TITLE
                                                        message:MESSAGE_ERROR_LOCATION_MANAGER delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    [alertView show];
}

- (IBAction)searchbarButtonPressed:(id)sender {
    
    if ([self.oSearchbar.text length] > 0) {
        [self performSearchForString:self.oSearchbar.text];
    }
}


- (void) actionContentTap:(UIGestureRecognizer*) recognizer {
    
    [self.view endEditing:YES];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showMapResults"]) {
        MapResultsViewController *targetVC = segue.destinationViewController;
        targetVC.locations = self.results;
        self.results = nil;
    }
}

#pragma mark - Private
- (void) setupLocationManager
{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
}

- (void) performSearchForUserLocation {

    self.retrievePending = true;
    [self.locationManager startUpdatingLocation];
}


- (void) performSearchForString:(NSString*) string {
    
    NSString* newString = [NSString stringWithFormat:@"germany, %@", string];
    CLGeocoder* geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:newString completionHandler:^(NSArray *placemarks, NSError *error) {
       
        if (error || !placemarks || placemarks.count == 0) {
            
            NSString* message = nil;
            
            switch (error.code) {
                case kCLErrorGeocodeFoundNoResult:
                    message = MESSAGE_ERROR_GEOCODER_NO_RESULT;
                    break;
                    
                default:
                    message = MESSAGE_ERROR_GEOCODER_GENERAL;
                    break;
            }
            
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:ALERT_TITLE
                                                                message:message
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
        else {
            
            CLLocationCoordinate2D location = ((CLPlacemark*)placemarks[0]).location.coordinate;
            [self performSearchForLocation:location];
        }
    }];
}


- (void) performSearchForLocation:(CLLocationCoordinate2D) location {
    
    uint currentRadius = INITIAL_RADIUS;
    CLCircularRegion* region = [[CLCircularRegion alloc] initWithCenter:location radius:currentRadius identifier:@"region"];
    NSArray* results = [[LocationManager instance] locationsWithinRegion:region];
    
    while (results.count < MINIMUM_RESULTS && currentRadius < MAXIMUM_RADIUS)  {
        
        currentRadius += RADIUS_INCREMENT;
        region = [[CLCircularRegion alloc] initWithCenter:location radius:currentRadius identifier:@"region"];
        results = [[LocationManager instance] locationsWithinRegion:region];
    }
    
    NSLog(@"Search within region: %@", region);
    NSLog(@"Result count: %lu", (unsigned long)results.count);

    _results = results;
    [self performSegueWithIdentifier:@"showMapResults" sender:self];
}




#pragma mark - Delegate

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {

    [searchBar resignFirstResponder];
    
    [self performSearchForString:searchBar.text];
}


- (void) locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{

    if (status == kCLAuthorizationStatusAuthorized
        || status == kCLAuthorizationStatusAuthorizedAlways
        || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        
        NSLog(@"User ganted permission for location service.");
        [self performSearchForUserLocation];
    } else {
        NSLog(@"User denied permission for location service.");
    }
    
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    if (self.isRetrievingPending) {
        
        self.retrievePending = false;
        CLLocationCoordinate2D userLocation = manager.location.coordinate;
        [manager stopUpdatingLocation];
        self.locationManager = nil;
        [self performSearchForLocation:userLocation];
    }
}


- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    if (error.code == kCLErrorDenied) {
        [self handleUnauthorizedState];
    }
}


@end
