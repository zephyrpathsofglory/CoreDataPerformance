//
//  Median+CoreDataProperties.m
//  CoreDataPerformance
//
//  Created by brave on 2017/7/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "Median+CoreDataProperties.h"

@implementation Median (CoreDataProperties)

+ (NSFetchRequest<Median *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Median"];
}

@dynamic textValue;
@dynamic id;
@dynamic floatValue;
@dynamic doubleValue;
@dynamic booleanValue;

@end
