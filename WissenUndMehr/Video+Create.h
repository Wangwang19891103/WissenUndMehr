//
//  Video+Create.h
//  WissenUndMehr
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//
#import "Video.h"

@interface Video (Create)

+ (Video *) videoFromInfoDict:(NSDictionary *)info inManagedObjectContext:(NSManagedObjectContext *)context;

@end
