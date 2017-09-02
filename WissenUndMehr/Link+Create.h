//
//  Link+Create.h
//  WissenUndMehr
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//
#import "Link.h"

@interface Link (Create)

+ (Link *) linkFromInfoDict:(NSDictionary *)navInfo inManagedObjectContext:(NSManagedObjectContext *)context;

@end
