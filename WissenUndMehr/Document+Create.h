//
//  Document+Create.h
//  WissenUndMehr
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import "Document.h"

@interface Document (Create)

+ (Document *) documentFromInfoDict:(NSDictionary *)navInfo inManagedObjectContext:(NSManagedObjectContext *)context;

@end
