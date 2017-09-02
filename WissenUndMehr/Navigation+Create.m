//
//  Navigation+Create.m
//  WissenUndMehr
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import "Navigation+Create.h"
#import "DataManager.h"
#import "Link+Create.h"
#import "Document+Create.h"
#import "Image+Create.h"
#import "Video+Create.h"

@implementation Navigation (Create)

+ (Navigation *) navigationFromInfoDict:(NSDictionary *)navInfo inManagedObjectContext:(NSManagedObjectContext *)context {
    
    Navigation *navElement = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Navigation"];
    request.predicate = [NSPredicate predicateWithFormat:@"uniqueId = %@", [navInfo objectForKey:kNAVIGATION_ID]];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"orderId" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error = nil;
    NSArray *navElements = [context executeFetchRequest:request error:&error];
    
    if (!navElements || ([navElements count] > 1)) {
        //we have an error
        NSLog(@"Error fetching Navigation: %@",error.localizedDescription);
    } else if (![navElements count]){
        //we dont have such an object in the database
        navElement = [NSEntityDescription insertNewObjectForEntityForName:@"Navigation" inManagedObjectContext:context];
        navElement.uniqueId = [navInfo objectForKey:kNAVIGATION_ID];
    } else {
        //we have found the object and update
        navElement = [navElements lastObject];
        
        //@TODO: Test this!
        //We reset the relationships so that if a nav element gets rearanged the structure does not get confused
        navElement.parent = nil;
        navElement.children = nil;
    }
    
    navElement.title = [navInfo objectForKey:kNAVIGATION_TITLE];
    navElement.subtitle = [navInfo objectForKey:kNAVIGATION_SUBTITLE];
    navElement.color = [navInfo objectForKey:kNAVIGATION_COLOR];
    navElement.lang = [navInfo objectForKey:kNAVIGATION_LANG];
    navElement.orderId = [navInfo objectForKey:kNAVIGATION_ORDERID];
    
    if ([navInfo objectForKey:kNAVIGATION_LINK]) {
        navElement.link = [Link linkFromInfoDict:[navInfo objectForKey:kNAVIGATION_LINK] inManagedObjectContext:context];
    }
    
    if ([navInfo objectForKey:kNAVIGATION_DOCUMENT]) {
        navElement.document = [Document documentFromInfoDict:[navInfo objectForKey:kNAVIGATION_DOCUMENT] inManagedObjectContext:context];
    }
    
    if ([navInfo objectForKey:kNAVIGATION_IMAGE]) {
        navElement.image = [Image imageFromInfoDict:[navInfo objectForKey:kNAVIGATION_IMAGE] inManagedObjectContext:context];
    }
    
    if ([navInfo objectForKey:kNAVIGATION_VIDEO]) {
        navElement.video = [Video videoFromInfoDict:[navInfo objectForKey:kNAVIGATION_VIDEO] inManagedObjectContext:context];
    }
    
    if ([navInfo objectForKey:kNAVIGATION_CHILDREN]) {
        NSDictionary *children = [navInfo objectForKey:kNAVIGATION_CHILDREN];

        [children enumerateKeysAndObjectsUsingBlock:^(id key, id object, BOOL *stop){
            
            [navElement addChildrenObject:[Navigation navigationFromInfoDict:object inManagedObjectContext:context]];
        }];
    }
    
    return navElement;
}

@end
