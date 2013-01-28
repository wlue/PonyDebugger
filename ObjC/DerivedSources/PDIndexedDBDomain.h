//
//  PDIndexedDBDomain.h
//  PonyDebuggerDerivedSources
//
//  Generated on 1/28/13
//
//  Licensed to Square, Inc. under one or more contributor license agreements.
//  See the LICENSE file distributed with this work for the terms under
//  which Square, Inc. licenses this file to you.
//

#import <PonyDebugger/PDObject.h>
#import <PonyDebugger/PDDebugger.h>
#import <PonyDebugger/PDDynamicDebuggerDomain.h>

@class PDIndexedDBDatabaseWithObjectStores;
@class PDIndexedDBKeyRange;
@class PDIndexedDBSecurityOriginWithDatabaseNames;

@protocol PDIndexedDBCommandDelegate;

@interface PDIndexedDBDomain : PDDynamicDebuggerDomain 

@property (nonatomic, assign) id <PDIndexedDBCommandDelegate, PDCommandDelegate> delegate;

@end

@protocol PDIndexedDBCommandDelegate <PDCommandDelegate>
@optional

// Enables events from backend.
- (void)domain:(PDIndexedDBDomain *)domain enableWithCallback:(void (^)(id error))callback;

// Disables events from backend.
- (void)domain:(PDIndexedDBDomain *)domain disableWithCallback:(void (^)(id error))callback;

// Requests database names for given frame's security origin.
// Param frameId: Frame id.
// Callback Param securityOriginWithDatabaseNames: Frame with database names.
- (void)domain:(PDIndexedDBDomain *)domain requestDatabaseNamesForFrameWithFrameId:(NSString *)frameId callback:(void (^)(PDIndexedDBSecurityOriginWithDatabaseNames *securityOriginWithDatabaseNames, id error))callback;

// Requests database with given name in given frame.
// Param frameId: Frame id.
// Param databaseName: Database name.
// Callback Param databaseWithObjectStores: Database with an array of object stores.
- (void)domain:(PDIndexedDBDomain *)domain requestDatabaseWithFrameId:(NSString *)frameId databaseName:(NSString *)databaseName callback:(void (^)(PDIndexedDBDatabaseWithObjectStores *databaseWithObjectStores, id error))callback;

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

@end

@interface PDDebugger (PDIndexedDBDomain)

@property (nonatomic, readonly, strong) PDIndexedDBDomain *indexedDBDomain;

@end
