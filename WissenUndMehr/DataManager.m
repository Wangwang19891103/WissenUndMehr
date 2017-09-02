//
//  DataImporter.m
//  WissenUndMehr
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import "DataManager.h"
#import "Navigation.h"

@implementation DataManager

+ (NSArray *) importDataFromFile:(NSString *)importFileName {
    
    NSDictionary *contentOfPlist = nil;
    NSString *commonDictionaryPath = nil;
    NSBundle *thisBundle = [NSBundle bundleForClass:[self class]];
    if ((commonDictionaryPath = [thisBundle pathForResource:importFileName ofType:@"plist"]))  {
        
        NSString *errorDesc = nil;
        NSPropertyListFormat format;
        
        NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:commonDictionaryPath];
        NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization
                                              propertyListFromData:plistXML
                                              mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                              format:&format
                                              errorDescription:&errorDesc];
        if (!temp) {
            NSLog(@"Error reading plist: %@", errorDesc);
        } else {
            contentOfPlist = temp;
        }
    }
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:[contentOfPlist count]];
    
    [contentOfPlist enumerateKeysAndObjectsUsingBlock:^(id key, id object, BOOL *stop){
        if ([key isEqualToString:@"Version"]) {
            [DataManager saveToUserDefaultsWithValue:object andKey:key];
        } else {
            [result addObject:object];
        }
    }];
    
    return [result copy];
}

+ (void) saveToUserDefaultsWithValue:(id)value andKey:(NSString *)aKey {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:value forKey:aKey];
    [userDefaults synchronize];
}

+ (id) getValueFromUserDefault:(NSString *)aKey {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:aKey];
}

+ (UIManagedDocument *) getManagedDocument {
    
    NSURL *documentsUrl = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    documentsUrl = [documentsUrl URLByAppendingPathComponent:[DataManager getDatabaseName]];

    UIManagedDocument *manDoc = [[UIManagedDocument alloc] initWithFileURL:documentsUrl];
    
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    manDoc.persistentStoreOptions = options;
    
    return manDoc;
}

+ (BOOL)atomicCopyItemAtURL:(NSURL *)sourceURL
                      toURL:(NSURL *)destinationURL
                      error:(NSError **)outError
{
    NSFileManager *manager = [NSFileManager defaultManager];
    
    // First copy into a temporary location where failure doesn't matter
    NSURL *tempDir = [manager URLForDirectory:NSItemReplacementDirectory
                                     inDomain:NSUserDomainMask
                            appropriateForURL:destinationURL
                                       create:YES
                                        error:outError];
    
    if (!tempDir) return NO;
    
    NSURL *tempURL = [tempDir URLByAppendingPathComponent:[destinationURL lastPathComponent]];
    
    BOOL result = [manager copyItemAtURL:sourceURL toURL:tempURL error:outError];
    if (result)
    {
        // Move the complete item into place, replacing any existing item in the process
        NSURL *resultingURL;
        result = [manager replaceItemAtURL:destinationURL
                             withItemAtURL:tempURL
                            backupItemName:nil
                                   options:NSFileManagerItemReplacementUsingNewMetadataOnly
                          resultingItemURL:&resultingURL
                                     error:outError];
        
        if (result)
        {
            NSAssert([resultingURL.absoluteString isEqualToString:destinationURL.absoluteString],
                     @"URL unexpectedly changed during replacement from:\n%@\nto:\n%@",
                     destinationURL,
                     resultingURL);
        }
    }
    
    // Clean up
    NSError *error;
    if (![manager removeItemAtURL:tempDir error:&error])
    {
        NSLog(@"Failed to remove temp directory after atomic copy: %@", error);
    }
    
    return result;
}

+ (NSArray *)determineOrphanedElements:(NSArray *)newHierarchicalElements oldImport:(NSArray *)oldFlattendedElements {
    
    NSMutableArray *orphanedElementsResult = [NSMutableArray array];
    
    //the hierarchical element array needs to be flattened first
    NSArray *flattenedResult;
    flattenedResult = [DataManager flattenArray:newHierarchicalElements];
    
    if (!flattenedResult && [flattenedResult count] == 0) {
        return orphanedElementsResult; //we return imediatly
    }
    
    [orphanedElementsResult addObjectsFromArray:oldFlattendedElements];
    
    //we substract the results from the flattened new elements
    [orphanedElementsResult removeObjectsInArray:flattenedResult];
    
    return orphanedElementsResult;
}

+ (NSArray *) flattenArray:(NSArray *)arrayToFlatten {
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:[arrayToFlatten count]];
    
    for (Navigation *navElement in arrayToFlatten) {
        [result addObject:navElement];
        
        if ([navElement.children count] > 0) {
            //we have children
            [result addObjectsFromArray:[DataManager flattenArray:[navElement.children allObjects]]];
        }
    }
    
    return result;
}

+ (BOOL) updateNeeded {
    
    return YES;
    
    NSString *versionOnDisk = [DataManager getValueFromUserDefault:@"Version"];
    NSString *versionInContentFile = [DataManager getObjectForKey:@"Version" fromDocument:@"ContentFile"];
    
    if ([versionOnDisk doubleValue] < [versionInContentFile doubleValue]) {
        return YES;
    }
    
    return NO;
}

/*! Returns an object for given key in given document
 \param aKey A key to look for
 \param aDocumentsName A document name (without ending) to look for the key (must be plist)
 \return Returns an object or nil
 */
+ (id)getObjectForKey:(NSString *)aKey fromDocument:(NSString *)aDocumentsName {
    
    NSDictionary *contentOfPlist = nil;
    NSString *commonDictionaryPath = nil;
    NSBundle *thisBundle = [NSBundle bundleForClass:[self class]];
    if ((commonDictionaryPath = [thisBundle pathForResource:aDocumentsName ofType:@"plist"]))  {
        
        NSString *errorDesc = nil;
        NSPropertyListFormat format;
        
        NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:commonDictionaryPath];
        NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization
                                              propertyListFromData:plistXML
                                              mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                              format:&format
                                              errorDescription:&errorDesc];
        if (!temp) {
            NSLog(@"Error reading plist: %@", errorDesc);
        } else {
            contentOfPlist = temp;
        }
    }
    
    return [contentOfPlist objectForKey:aKey];
}

+ (NSString *) getDatabaseName {
    return @"Default Content Database";
}

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    
    NSError *error = nil;
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
}

@end
