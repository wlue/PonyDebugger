//
//  PDDatabaseDomainController.m
//  PonyDebugger
//
//  Created by Mike Lewis on 2/29/12.
//
//  Licensed to Square, Inc. under one or more contributor license agreements.
//  See the LICENSE file distributed with this work for the terms under
//  which Square, Inc. licenses this file to you.
//

#import "PDIndexedDBDomainController.h"
#import "PDRuntimeDomainController.h"
#import "PDIndexedDBTypes.h"
#import "PDRuntimeTypes.h"

#import <CoreData/CoreData.h>


static NSString *const PDManagedObjectContextNameUserInfoKey = @"PDManagedObjectContextName";


@interface PDIndexedDBDomainController ()

@property (nonatomic, strong) NSMutableArray *managedObjectContexts;

- (NSManagedObjectContext *)_managedObjectContextForName:(NSString *)name;
- (NSString *)_databaseNameForManagedObjectContext:(NSManagedObjectContext *)context;

- (PDIndexedDBDatabaseWithObjectStores *)_databaseWithObjectStoresForContext:(NSManagedObjectContext *)context;

@end


@implementation PDIndexedDBDomainController

@dynamic domain;

@synthesize managedObjectContexts = _managedObjectContexts;

#pragma mark - Statics

+ (PDIndexedDBDomainController *)defaultInstance;
{
    static PDIndexedDBDomainController *defaultInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultInstance = [[PDIndexedDBDomainController alloc] init];
    });
    
    return defaultInstance;
}

+ (Class)domainClass;
{
    return [PDIndexedDBDomain class];
}

#pragma mark - Initialization

- (id)init;
{
    self = [super init];
    if (self) {
        self.managedObjectContexts = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)dealloc;
{
    self.managedObjectContexts = nil;
}

#pragma mark - PDIndexedDBCommandDelegate

// Enables events from backend.
- (void)domain:(PDIndexedDBDomain *)domain enableWithCallback:(void (^)(id error))callback;
{
    callback(nil);
}

// Disables events from backend.
- (void)domain:(PDIndexedDBDomain *)domain disableWithCallback:(void (^)(id error))callback;
{
    callback(nil);
}

// Requests database names for given frame's security origin.
// Param frameId: Frame id.
// Callback Param securityOriginWithDatabaseNames: Frame with database names.
- (void)domain:(PDIndexedDBDomain *)domain requestDatabaseNamesForFrameWithFrameId:(NSString *)frameId callback:(void (^)(PDIndexedDBSecurityOriginWithDatabaseNames *securityOriginWithDatabaseNames, id error))callback;
{
    NSMutableArray *dbNames = [[NSMutableArray alloc] initWithCapacity:_managedObjectContexts.count];
    [self.managedObjectContexts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSManagedObjectContext *context = obj;
        [dbNames addObject:[context.userInfo objectForKey:PDManagedObjectContextNameUserInfoKey]];
    }];
    
    PDIndexedDBSecurityOriginWithDatabaseNames *databaseNames = [[PDIndexedDBSecurityOriginWithDatabaseNames alloc] init];
    databaseNames.databaseNames = dbNames;
    databaseNames.securityOrigin = [[NSBundle mainBundle] bundleIdentifier];

    callback(databaseNames, nil);
}


// Requests database with given name in given frame.
// Param frameId: Frame id.
// Param databaseName: Database name.
// Callback Param databaseWithObjectStores: Database with an array of object stores.
- (void)domain:(PDIndexedDBDomain *)domain requestDatabaseWithFrameId:(NSString *)frameId databaseName:(NSString *)databaseName callback:(void (^)(PDIndexedDBDatabaseWithObjectStores *databaseWithObjectStores, id error))callback;
{
    NSManagedObjectContext *context = [self _managedObjectContextForName:databaseName];
    PDIndexedDBDatabaseWithObjectStores *databaseWithObjectStores = [self _databaseWithObjectStoresForContext:context];
    callback(databaseWithObjectStores, nil);
}

// Requests data from object store or index.
// Param frameId: Frame id.
// Param databaseName: Database name.
// Param objectStoreName: Object store name.
// Param indexName: Index name, empty string for object store data requests.
// Param skipCount: Number of records to skip.
// Param pageSize: Number of records to fetch.
// Param keyRange: Key range.
// Callback Param objectStoreDataEntries: Array of object store data entries.
// Callback Param hasMore: If true, there are more entries to fetch in the given range.
- (void)domain:(PDIndexedDBDomain *)domain requestDataWithFrameId:(NSString *)frameId databaseName:(NSString *)databaseName objectStoreName:(NSString *)objectStoreName indexName:(NSString *)indexName skipCount:(NSNumber *)skipCount pageSize:(NSNumber *)pageSize keyRange:(PDIndexedDBKeyRange *)keyRange callback:(void (^)(NSArray *objectStoreDataEntries, NSNumber *hasMore, id error))callback;
{
    NSManagedObjectContext *context = [self _managedObjectContextForName:databaseName];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:objectStoreName];

    // Don't show subentities if it's not an abstract entity.
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:objectStoreName inManagedObjectContext:context];
    if (![entityDescription isAbstract]) {
        fetchRequest.includesSubentities = NO;
    }

    NSInteger totalCount = [context countForFetchRequest:fetchRequest error:NULL];
    
    fetchRequest.fetchOffset = [skipCount integerValue];
    fetchRequest.fetchLimit = [pageSize integerValue];
    
    NSArray *results = [context executeFetchRequest:fetchRequest error:NULL];
    NSMutableArray *dataEntries = [[NSMutableArray alloc] initWithCapacity:results.count];
    
    for (NSManagedObject *object in results) {
        PDIndexedDBDataEntry *dataEntry = [[PDIndexedDBDataEntry alloc] init];

        PDRuntimeRemoteObject *primaryKey = [[PDRuntimeRemoteObject alloc] init];
        primaryKey.type = @"string";
        primaryKey.value = primaryKey.objectDescription = [[object.objectID URIRepresentation] absoluteString];

        dataEntry.primaryKey = primaryKey;

        // Ensure custom indexes yield strings.
        if (indexName.length > 0) {
            PDRuntimeRemoteObject *key = [[PDRuntimeRemoteObject alloc] init];
            key.type = @"string";
            key.value = key.objectDescription = [NSString stringWithFormat:@"%@", [object valueForKey:indexName]];
            dataEntry.key = key;
        } else {
            dataEntry.key = primaryKey;
        }
        
        PDRuntimeRemoteObject *remoteObject = [[PDRuntimeRemoteObject alloc] init];
        remoteObject.objectId = [[PDRuntimeDomainController defaultInstance] registerAndGetKeyForObject:object];
        remoteObject.type = @"object";
        remoteObject.classNameString = remoteObject.objectDescription = objectStoreName;
        
        dataEntry.value = remoteObject;
        
        [dataEntries addObject:dataEntry];
    }
    
    NSNumber *hasMore = [NSNumber numberWithBool:YES];
    if (fetchRequest.fetchOffset + results.count >= totalCount) {
        hasMore = [NSNumber numberWithBool:NO];
    }

    callback(dataEntries, hasMore, nil);
}


#pragma mark - Public Methods

- (void)addManagedObjectContext:(NSManagedObjectContext *)context;
{
    NSString *name = [self _databaseNameForManagedObjectContext:context];
    [self addManagedObjectContext:context withName:name];
}

- (void)addManagedObjectContext:(NSManagedObjectContext *)context withName:(NSString *)name;
{
    [context.userInfo setObject:name forKey:PDManagedObjectContextNameUserInfoKey];
    [_managedObjectContexts addObject:context];
}

- (void)removeManagedObjectContext:(NSManagedObjectContext *)context;
{
    [self.managedObjectContexts removeObject:context];
}

#pragma mark - Private Methods

- (NSManagedObjectContext *)_managedObjectContextForName:(NSString *)name;
{
    for (NSManagedObjectContext *context in self.managedObjectContexts) {
        if ([[context.userInfo objectForKey:PDManagedObjectContextNameUserInfoKey] isEqualToString:name]) {
            return context;
        }
    }
    
    return nil;
}

- (NSString *)_databaseNameForManagedObjectContext:(NSManagedObjectContext *)context;
{
    NSMutableArray *paths = [[NSMutableArray alloc] init];
    for (NSPersistentStore *store in context.persistentStoreCoordinator.persistentStores) {
        NSURL *url = [context.persistentStoreCoordinator URLForPersistentStore:store];
        NSString *pathString = [url.lastPathComponent stringByDeletingPathExtension];
        if (pathString) {
            [paths addObject:pathString];
        }
    }
    
    return [paths componentsJoinedByString:@":"];
}

- (PDIndexedDBDatabaseWithObjectStores *)_databaseWithObjectStoresForContext:(NSManagedObjectContext *)context;
{
    NSMutableArray *objectStores = [[NSMutableArray alloc] init];
    
    for (NSEntityDescription *entity in context.persistentStoreCoordinator.managedObjectModel.entities) {
        PDIndexedDBObjectStore *objectStore = [[PDIndexedDBObjectStore alloc] init];
        
        PDIndexedDBKeyPath *keyPath = [[PDIndexedDBKeyPath alloc] init];
        keyPath.type = @"string";
        keyPath.string = @"objectID";
        
        objectStore.keyPath = keyPath;
        
        NSMutableArray *indexes = [[NSMutableArray alloc] init];
        for (NSAttributeDescription *property in [[entity attributesByName] allValues]) {
            if ([property isIndexed]) {
                PDIndexedDBObjectStoreIndex *index = [[PDIndexedDBObjectStoreIndex alloc] init];
                index.name = property.name;
                
                PDIndexedDBKeyPath *guidKeyPath = [[PDIndexedDBKeyPath alloc] init];
                guidKeyPath.type = @"string";
                guidKeyPath.string = property.name;
                
                index.keyPath = guidKeyPath;
                index.unique = [NSNumber numberWithBool:NO];
                index.multiEntry = [NSNumber numberWithBool:NO];
                
                [indexes addObject:index];
            }
        }
        objectStore.indexes = indexes;
        
        objectStore.autoIncrement = [NSNumber numberWithBool:NO];
        objectStore.name = entity.name;
        
        [objectStores addObject:objectStore];
    }
       
    PDIndexedDBDatabaseWithObjectStores *db = [[PDIndexedDBDatabaseWithObjectStores alloc] init];
    
    db.name = [self _databaseNameForManagedObjectContext:context];
    db.version = @"N/A";
    db.objectStores = objectStores;

    return db;
}

@end
