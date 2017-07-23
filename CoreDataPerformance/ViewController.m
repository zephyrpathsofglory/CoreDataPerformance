//
//  ViewController.m
//  CoreDataPerformance
//
//  Created by brave on 2017/7/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Median+CoreDataProperties.h"
#import <mach/mach_time.h>
#import "CoreDataManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesBegan");
    
    [self testCURD:200];
    [self testCURD:1000];
    [self testCURD:2000];
    [self testCURD:4000];

}

- (void)testCURD:(int)insertedNum{
    CoreDataManager *manager = [[CoreDataManager alloc] init];
    [manager insertData:insertedNum];
    [manager selectData:insertedNum];
    [manager updateData:insertedNum];
    [manager deleteData:insertedNum];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
