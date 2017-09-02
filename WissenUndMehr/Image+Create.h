//
//  Image+Create.h
//  WissenUndMehr
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import "Image.h"

@interface Image (Create)

+ (Image *) imageFromInfoDict:(NSDictionary *)navInfo inManagedObjectContext:(NSManagedObjectContext *)context;

@end
