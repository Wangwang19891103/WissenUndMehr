//
//  Link+Create.m
//  WissenUndMehr
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import "Link+Create.h"
#import "DataManager.h"

@implementation Link (Create)

+ (Link *) linkFromInfoDict:(NSDictionary *)info inManagedObjectContext:(NSManagedObjectContext *)context {
    
    Link *link = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Link"];
    request.predicate = [NSPredicate predicateWithFormat:@"fileURL = %@", [info objectForKey:kLINK_FILEURL]];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error = nil;
    NSArray *links = [context executeFetchRequest:request error:&error];
    
    if (!links || ([links count] > 1)) {
        //we have an error
        NSLog(@"Error fetching Links: %@",error.localizedDescription);
    } else if (![links count]){
        //we dont have such an object in the database
        link = [NSEntityDescription insertNewObjectForEntityForName:@"Link" inManagedObjectContext:context];
    } else {
        //we have found the object and update
        link = [links lastObject];
    }
    
    link.fileURL = [info objectForKey:kLINK_FILEURL];
    link.name = [info objectForKey:kLINK_NAME];
    
    return link;
}

@end
