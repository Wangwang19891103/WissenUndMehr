//
//  LocationDataManager.h
//  SchülerhilfeMap
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationDataManager.h"
#import <MapKit/MapKit.h>
#import "Location.h"
#import <AddressBook/AddressBook.h>


@interface LocationManager : NSObject {
    
    LocationDataManager* _dataManager;
}


+ (LocationManager*) instance;

- (NSArray*) locationsWithinRegion:(CLCircularRegion*) region;

- (NSArray*) mapItemsWithinRegion:(CLCircularRegion*) region;

- (MKMapItem*) mapItemFromLocation:(Location*) location;

- (NSArray*) mapItemsFromLocations:(NSArray*) locations;

@end
