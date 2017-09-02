//
//  DataManager.h
//  Sprachenraetsel
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
    DataManagerStoreLocationBundle,
    DataManagerStoreLocationDocuments
} DataManagerStoreLocation;

@interface LocationDataManager : NSObject {
    NSManagedObjectContext* _context;
}

- (id) initWithModelName:(NSString*) modelName storeName:(NSString*) storeName location:(DataManagerStoreLocation) location;

- (id) initWithModelName:(NSString*) modelName path:(NSString *)path;

//+ (DataManager*) sharedInstance;

//+ (DataManager*) contentInstance;
//+ (DataManager*) importedContentInstance;
//+ (DataManager*) playerInstance;

+ (LocationDataManager*) instanceNamed:(NSString*) name;

+ (LocationDataManager*) instanceInBundleNamed:(NSString *)name;


- (void) addStoreInDocumentsWithPath:(NSString*) path;

- (id) insertNewObjectForEntityName:(NSString*) name;

- (NSArray*) fetchDataForEntityName:(NSString*) name withPredicate: (NSPredicate*) predicate sortedBy: (NSString*) firstSorter, ...;

- (id) fetchOrCreateObjectForEntityName:(NSString*) name withPredcate:(NSPredicate*) predicate;

- (int) countForEntity:(NSString*) entityName;

- (void) deleteObject:(id) object;

- (void) save;
- (void) clearStore;
- (void) handleError:(NSError*) error;

//- (void) copyDatabase;

@end

