//
//  Median+CoreDataProperties.h
//  CoreDataPerformance
//
//  Created by brave on 2017/7/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "Median+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Median (CoreDataProperties)

+ (NSFetchRequest<Median *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *text1;
@property (nullable, nonatomic, copy) NSString *text2;
@property (nullable, nonatomic, copy) NSString *textValue;
@property (nullable, nonatomic, copy) NSString *textValue2;
@property (nonatomic) int64_t tid;
@property (nonatomic) int64_t timestamp1;
@property (nonatomic) double type1;
@property (nonatomic) double type2;
@property (nonatomic) BOOL value1;
@property (nonatomic) BOOL value2;

@end

NS_ASSUME_NONNULL_END
