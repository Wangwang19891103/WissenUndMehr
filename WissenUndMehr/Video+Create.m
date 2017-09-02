//
//  Video+Create.m
//  WissenUndMehr
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import "Video+Create.h"
#import "DataManager.h"

@implementation Video (Create)

+ (Video *) videoFromInfoDict:(NSDictionary *)info inManagedObjectContext:(NSManagedObjectContext *)context {
    
    Video *video = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Video"];
    request.predicate = [NSPredicate predicateWithFormat:@"uniqueId = %@", [info objectForKey:kVIDEO_ID]];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error = nil;
    NSArray *videos = [context executeFetchRequest:request error:&error];
    
    if (!videos || ([videos count] > 1)) {
        //we have an error
        NSLog(@"Error fetching Videos: %@",error.localizedDescription);
    } else if (![videos count]){
        //we dont have such an object in the database
        video = [NSEntityDescription insertNewObjectForEntityForName:@"Video" inManagedObjectContext:context];
        video.uniqueId = [info objectForKey:kVIDEO_ID];
    } else {
        //we have found the object and update
        video = [videos lastObject];
    }
    
    video.url = [info objectForKey:kVIDEO_URL];
    video.name = [info objectForKey:kVIDEO_NAME];
    video.title = [info objectForKey:kVIDEO_TITLE];
    video.summary = [info objectForKey:kVIDEO_SUMMARY];
    
    return video;
}


@end
