//
//  CoreDataUtil.m
//  CoreDataPerformance
//
//  Created by brave on 2017/7/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CoreDataUtil.h"

@implementation CoreDataUtil
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
- (double)insertData:(int)insertSize{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSError *error;
    NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
    for (int i = 0; i < insertSize; i++)  {
        Median *medianInfo = [NSEntityDescription insertNewObjectForEntityForName:TableName inManagedObjectContext:context];
        medianInfo.tid = i;
        medianInfo.timestamp1 = i * i;
        medianInfo.textValue = @"adbcdefg.123456789.123456789";
        medianInfo.textValue2 = @"adbcdefg.123456789.123456789";
        medianInfo.text1 = @"init_text";
        medianInfo.text2 = @"init_text";
        medianInfo.type1 = 1.5000;
        medianInfo.type2 = 1.5000;
        medianInfo.value1 = true;
        medianInfo.value2 = false;
    }
    
    if (![context save:&error]) {
        NSLog(@"插入失败：-------%@",[error localizedDescription]);
    }
    NSTimeInterval stop = [NSDate timeIntervalSinceReferenceDate];
    return (stop - start) * 1000 * 1000;
}
//查询
- (double)selectData:(int)fetchSize{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"tid<%d",fetchSize]];
    NSEntityDescription *entity = [NSEntityDescription entityForName:TableName inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    NSTimeInterval stop = [NSDate timeIntervalSinceReferenceDate];
    if (fetchedObjects.count != fetchSize) {
        NSLog(@"query fault!");
    }
    return (stop - start) * 1000 * 1000;
}

- (double)selectAll{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:TableName inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    NSTimeInterval stop = [NSDate timeIntervalSinceReferenceDate];
    if (fetchedObjects.count != 10000) {
        NSLog(@"query all fault!");
    }
    return (stop - start) * 1000 * 1000;
}

//删除
- (double)deleteData:(int)deleteSize{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"tid<%d",deleteSize]];
    NSEntityDescription *entity = [NSEntityDescription entityForName:TableName inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    NSError *deleteError = nil;
    NSTimeInterval start = 0;
    NSTimeInterval stop = 0;
    if (!error && fetchedObjects &&[fetchedObjects count]) {
        start = [NSDate timeIntervalSinceReferenceDate];
        for (NSManagedObject *obj in fetchedObjects) {
            [context deleteObject:obj];
        }
        if (![context save:&deleteError]) {
            NSLog(@"error:%@",deleteError);
        }
        stop = [NSDate timeIntervalSinceReferenceDate];
    }
    return (stop - start) * 1000 * 1000;
}
//更新
- (double)updateData:(int)updateSize {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"tid<%d",updateSize]];
    NSEntityDescription *entity = [NSEntityDescription entityForName:TableName inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];

    NSError *updateError = nil;
    NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
    for (Median *info in fetchedObjects) {
        info.textValue = @"modified_text";
    }
    if (![context save:&updateError]) {
        NSLog(@"更新失败");
    }
    NSTimeInterval stop = [NSDate timeIntervalSinceReferenceDate];
    return (stop - start) * 1000 * 1000;
}

@end
