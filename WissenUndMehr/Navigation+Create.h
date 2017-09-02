//
//  Navigation+Create.h
//  WissenUndMehr
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import "Navigation.h"

@interface Navigation (Create)

+ (Navigation *) navigationFromInfoDict:(NSDictionary *)navInfo inManagedObjectContext:(NSManagedObjectContext *)context;

@end
