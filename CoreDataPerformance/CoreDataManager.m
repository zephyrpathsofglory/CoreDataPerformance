//
//  CoreDataManager.m
//  Demo_CoreData
//
//  Created by wangpanpan on 16/7/26.
//  Copyright © 2016年 wangpanpan. All rights reserved.
//

#import "CoreDataManager.h"

@implementation CoreDataManager
#pragma mark - Core Data Stack -

- (NSManagedObjectContext *)managedObjectContext{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *model = [[NSBundle mainBundle]URLForResource:@"CoreDataPerformance" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc]initWithContentsOfURL:model];
    return _managedObjectModel;
}
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentDirectory]URLByAppendingPathComponent:@"CoreDataPerformance.sqlite"];
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"%@--%@",error,[error userInfo]);
        abort();
    }
    return _persistentStoreCoordinator;
}
#pragma mark - Application's Documents Directory -
-(NSURL *)applicationDocumentDirectory{
    return [[[NSFileManager defaultManager]URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask]lastObject];
}

//插入数据
- (void)insertData:(int)insertSize{
    NSLog(@"insert begin");
    NSManagedObjectContext *context = [self managedObjectContext];
    NSError *error;
    NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
    for (int i = 0; i < insertSize; i++)  {
        Median *medianInfo = [NSEntityDescription insertNewObjectForEntityForName:TableName inManagedObjectContext:context];
        medianInfo.textValue = @"init_text";
        medianInfo.floatValue = 1.5;
        medianInfo.doubleValue = 1.5000;
        medianInfo.booleanValue = true;
        medianInfo.id = i;
    }

    if (![context save:&error]) {
        NSLog(@"插入失败：-------%@",[error localizedDescription]);
    }
    NSTimeInterval stop = [NSDate timeIntervalSinceReferenceDate];

    NSLog(@"insert %d records, costs %f us",insertSize,(stop - start) * 1000 * 1000);
}
//查询
- (NSArray *)selectData:(int)fetchSize{
    NSLog(@"select begin");
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"id<%d",fetchSize]];
    NSEntityDescription *entity = [NSEntityDescription entityForName:TableName inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    NSTimeInterval stop = [NSDate timeIntervalSinceReferenceDate];
    NSLog(@"select %d records. costs %f us",fetchSize, (stop - start) * 1000 * 1000);
    NSLog(@"query count:%lu",(unsigned long)fetchedObjects.count);
    return fetchedObjects;
}

//删除
- (void)deleteData:(int)deleteSize{
    NSLog(@"delete begin");
    NSManagedObjectContext *context = [self managedObjectContext];
    NSArray *datas = [self selectData:deleteSize];
    NSError *error = nil;
    if (!error && datas &&[datas count]) {
        NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
        for (NSManagedObject *obj in datas) {
            [context deleteObject:obj];
        }
        if (![context save:&error]) {
            NSLog(@"error:%@",error);
        }
        NSTimeInterval stop = [NSDate timeIntervalSinceReferenceDate];
        NSLog(@"delete %d records,costs %f us",deleteSize,(stop - start) * 1000 * 1000);
    }
}
//更新
- (void)updateData:(int)updateSize {
    NSLog(@"update begin");
    NSManagedObjectContext *context = [self managedObjectContext];

    NSArray *result = [self selectData:updateSize];
    NSError *error = nil;

    NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
    for (Median *info in result) {
        info.textValue = @"modified_text";
    }
    if (![context save:&error]) {
        NSLog(@"更新失败");
    }
    NSTimeInterval stop = [NSDate timeIntervalSinceReferenceDate];
    NSLog(@"update %d records ,costs %f us",updateSize,(stop - start) * 1000 * 1000);
}

@end
