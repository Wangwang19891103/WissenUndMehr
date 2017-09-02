//
//  DataImporter.h
//  WissenUndMehr
//
//  Created by Wang Wang on 17.10.13.
//  Copyright (c) 2013 Wang. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface DataManager : NSObject

#define kNAVIGATION_ORDERID @"orderId"
#define kNAVIGATION_COLOR @"color"
#define kNAVIGATION_LANG @"lang"
#define kNAVIGATION_SUBTITLE @"subtitle"
#define kNAVIGATION_TITLE @"title"
#define kNAVIGATION_CHILDREN @"children"
#define kNAVIGATION_DOCUMENT @"document"
#define kNAVIGATION_LINK @"link"
#define kNAVIGATION_IMAGE @"image"
#define kNAVIGATION_VIDEO @"video"
#define kNAVIGATION_ID @"uniqueId"

#define kIMAGE_FILEPATH @"fileName"
#define kIMAGE_NAME @"name"

#define kDOCUMENT_FILEPATH @"fileName"
#define kDOCUMENT_NAME @"name"

#define kLINK_FILEURL @"fileURL"
#define kLINK_NAME @"name"

#define kVIDEO_ID @"uniqueId"
#define kVIDEO_NAME @"name"
#define kVIDEO_URL @"url"
#define kVIDEO_SUMMARY @"summary"
#define kVIDEO_TITLE @"title"

+ (NSArray *) importDataFromFile:(NSString *)importFileName;
+ (void) saveToUserDefaultsWithValue:(id)value andKey:(NSString *)aKey;
+ (id) getValueFromUserDefault:(NSString *)aKey;
+ (UIManagedDocument *) getManagedDocument;
+ (NSString *) getDatabaseName;

+ (BOOL)atomicCopyItemAtURL:(NSURL *)sourceURL
                      toURL:(NSURL *)destinationURL
                      error:(NSError **)outError;

+ (NSArray *)determineOrphanedElements:(NSArray *)newHierarchicalElements oldImport:(NSArray *)oldFlattendedElements;
+ (NSArray *) flattenArray:(NSArray *)arrayToFlatten;
+ (BOOL) updateNeeded;
+ (id)getObjectForKey:(NSString *)aKey fromDocument:(NSString *)aDocumentsName;
+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;

@end
