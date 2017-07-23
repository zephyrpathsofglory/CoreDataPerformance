//
//  CoreDataManager.h
//  Demo_CoreData
//
//  Created by wangpanpan on 16/7/26.
//  Copyright © 2016年 wangpanpan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Median+CoreDataProperties.h"
#define  TableName @"Median"
@interface CoreDataManager : NSObject
@property (nonatomic,strong)NSManagedObjectContext *managedObjectContext;
@property (nonatomic,strong)NSManagedObjectModel *managedObjectModel;
@property (nonatomic,strong)NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSURL *)applicationDocumentDirectory;

//插入
- (void)insertData:(int)insertSize;
//查询
- (NSArray *)selectData:(int)fetchSize;
//删除
- (void)deleteData:(int)deleteSize;
//更新
- (void)updateData:(int)updateSize;
@end
