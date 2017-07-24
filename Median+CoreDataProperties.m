//
//  Median+CoreDataProperties.m
//  CoreDataPerformance
//
//  Created by brave on 2017/7/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "Median+CoreDataProperties.h"

@implementation Median (CoreDataProperties)

+ (NSFetchRequest<Median *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Median"];
}

@dynamic text1;
@dynamic text2;
@dynamic textValue;
@dynamic textValue2;
@dynamic tid;
@dynamic timestamp1;
@dynamic type1;
@dynamic type2;
@dynamic value1;
@dynamic value2;

@end
