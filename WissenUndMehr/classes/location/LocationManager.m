//
//  LocationDataManager.m
//  SchülerhilfeMap
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//
#import "LocationManager.h"



@implementation LocationManager


- (id) init {
    
    self = [super init];
    
    _dataManager = [LocationDataManager instanceInBundleNamed:@"locations"];
    
    return self;
}


+ (LocationManager*) instance {
    
    static LocationManager* __instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [[LocationManager alloc] init];
    });
    
    return __instance;
}


- (NSArray*) locationsWithinRegion:(CLCircularRegion *)region {

    NSArray* locations = [_dataManager fetchDataForEntityName:@"Location" withPredicate:nil sortedBy:@"id", nil];
    
    NSMutableArray* hits = [NSMutableArray array];
    
    for (Location* location in locations) {
        
        CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(location.latitude, location.longitude);
        
        if ([region containsCoordinate:coord]) {
            
            [hits addObject:location];
        }
    }
    
    return hits;
}


- (NSArray*) mapItemsWithinRegion:(CLCircularRegion*) region {
    
    NSArray* locations = [self locationsWithinRegion:region];
    
    NSMutableArray* mapItems = [NSMutableArray array];
    
    for (Location* location in locations) {
        
        MKMapItem* mapItem = [self mapItemFromLocation:location];
        [mapItems addObject:mapItem];
    }
    
    return mapItems;
}


- (MKMapItem*) mapItemFromLocation:(Location*) location {

    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(location.latitude, location.longitude);
    MKPlacemark* placemark = [[MKPlacemark alloc] initWithCoordinate:coord
                                                   addressDictionary:@{
                                                                       (NSString*)kABPersonAddressStreetKey : [NSString stringWithFormat:@"%@ %@", location.strasse, location.hausnr],
                                                                       (NSString*)kABPersonAddressZIPKey : location.plz,
                                                                       (NSString*)kABPersonAddressCityKey : location.ort
                                                                       }];
    MKMapItem* mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    
    return mapItem;
}


- (NSArray*) mapItemsFromLocations:(NSArray*) locations {
    
    NSMutableArray* mapItems = [NSMutableArray array];
    
    for (Location* location in locations) {
        
        [mapItems addObject:[self mapItemFromLocation:location]];
    }
    
    return mapItems;
}


@end
