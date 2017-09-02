//
//  Document+Create.m
//  WissenUndMehr
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import "Document+Create.h"
#import "DataManager.h"

@implementation Document (Create)

+ (Document *) documentFromInfoDict:(NSDictionary *)info inManagedObjectContext:(NSManagedObjectContext *)context {
    
    Document *document = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Document"];
    request.predicate = [NSPredicate predicateWithFormat:@"fileName = %@", [info objectForKey:kDOCUMENT_FILEPATH]];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error = nil;
    NSArray *documents = [context executeFetchRequest:request error:&error];
    
    if (!documents || ([documents count] > 1)) {
        //we have an error
        NSLog(@"Error fetching Documents: %@",error.localizedDescription);
    } else if (![documents count]){
        //we dont have such an object in the database
        document = [NSEntityDescription insertNewObjectForEntityForName:@"Document" inManagedObjectContext:context];
    } else {
        //we have found the object and update
        document = [documents lastObject];
    }
    
    document.fileName = [info objectForKey:kDOCUMENT_FILEPATH];
    document.name = [info objectForKey:kDOCUMENT_NAME];
    
    return document;
}

@end
