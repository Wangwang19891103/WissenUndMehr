//
//  Image+Create.m
//  WissenUndMehr
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//
#import "Image+Create.h"
#import "DataManager.h"

@implementation Image (Create)

+ (Image *) imageFromInfoDict:(NSDictionary *)info inManagedObjectContext:(NSManagedObjectContext *)context {
    
    Image *image = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Image"];
    request.predicate = [NSPredicate predicateWithFormat:@"fileName = %@", [info objectForKey:kIMAGE_FILEPATH]];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error = nil;
    NSArray *images = [context executeFetchRequest:request error:&error];
    
    if (!images || ([images count] > 1)) {
        //we have an error
        NSLog(@"Error fetching Images: %@",error.localizedDescription);
    } else if (![images count]){
        //we dont have such an object in the database
        image = [NSEntityDescription insertNewObjectForEntityForName:@"Image" inManagedObjectContext:context];
    } else {
        //we have found the object and update
        image = [images lastObject];
    }
    
    image.fileName = [info objectForKey:kIMAGE_FILEPATH];
    image.name = [info objectForKey:kIMAGE_NAME];
    
    return image;
}

@end
