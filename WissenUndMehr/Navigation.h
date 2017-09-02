//
//  Navigation.h
//  WissenUndMehr
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Document, Image, Link, Navigation, Video;

@interface Navigation : NSManagedObject

@property (nonatomic, retain) NSString * color;
@property (nonatomic, retain) NSString * lang;
@property (nonatomic, retain) NSNumber * orderId;
@property (nonatomic, retain) NSString * subtitle;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * uniqueId;
@property (nonatomic, retain) NSSet *children;
@property (nonatomic, retain) Document *document;
@property (nonatomic, retain) Image *image;
@property (nonatomic, retain) Link *link;
@property (nonatomic, retain) Navigation *parent;
@property (nonatomic, retain) Video *video;
@end

@interface Navigation (CoreDataGeneratedAccessors)

- (void)addChildrenObject:(Navigation *)value;
- (void)removeChildrenObject:(Navigation *)value;
- (void)addChildren:(NSSet *)values;
- (void)removeChildren:(NSSet *)values;

@end
