//
//  Median+CoreDataProperties.h
//  CoreDataPerformance
//
//  Created by brave on 2017/7/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "Median+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Median (CoreDataProperties)

+ (NSFetchRequest<Median *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *textValue;
@property (nonatomic) int32_t id;
@property (nonatomic) float floatValue;
@property (nonatomic) double doubleValue;
@property (nonatomic) BOOL booleanValue;

@end

NS_ASSUME_NONNULL_END
