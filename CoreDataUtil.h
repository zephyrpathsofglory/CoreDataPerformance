//
//  CoreDataUtil.h
//  CoreDataPerformance
//
//  Created by brave on 2017/7/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Median+CoreDataProperties.h"
#define TableName @"Median"
@interface CoreDataUtil : NSObject
@property (nonatomic,strong)NSManagedObjectContext *managedObjectContext;
@property (nonatomic,strong)NSManagedObjectModel *managedObjectModel;
@property (nonatomic,strong)NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSURL *)applicationDocumentDirectory;


//插入
- (double)insertData:(int)insertSize;
//查询
- (double)selectData:(int)fetchSize;
- (double)selectAll;
//删除
- (double)deleteData:(int)deleteSize;
//更新
- (double)updateData:(int)updateSize;
@end
