//
//  Location.h
//  SchülerhilfeMap
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Location : NSManagedObject

@property (nonatomic, retain) NSString * bundesland;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * hausnr;
@property (nonatomic, retain) NSString * homepage;
@property (nonatomic) int16_t id;
@property (nonatomic, retain) NSString * land;
@property (nonatomic) double latitude;
@property (nonatomic, retain) NSString * leiter;
@property (nonatomic) double longitude;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * ort;
@property (nonatomic, retain) NSString * plz;
@property (nonatomic, retain) NSString * rufnr;
@property (nonatomic, retain) NSString * strasse;
@property (nonatomic, retain) NSString * vorwahl;

@end
