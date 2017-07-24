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
#import "CoreDataUtil.h"
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
    int loop = 100;
    CoreDataUtil *util = [[CoreDataUtil alloc] init];

    //查询和更新
    [util insertData:10000];
    double totalQuery100 = 0;
    double totalQuery500 = 0;
    double totalQuery1000 = 0;
    double totalQuery2000 = 0;
    double totalQuery4000 = 0;

    double totalUpdate100 = 0;
    double totalUpdate500 = 0;
    double totalUpdate1000 = 0;
    double totalUpdate2000 = 0;
    double totalUpdate4000 = 0;
    for (int i = 0; i < loop; i++) {
        double queryTime100 = [util selectData:100];
        totalQuery100 += queryTime100;
        double updateTime100 = [util updateData:100];
        totalUpdate100 += updateTime100;
    }
    for (int i = 0; i < loop; i++) {
        double queryTime500 = [util selectData:500];
        totalQuery500 += queryTime500;
        double updateTime500 = [util updateData:500];
        totalUpdate500 += updateTime500;
    }
    for (int i = 0; i < loop; i++) {
        double queryTime1000 = [util selectData:1000];
        totalQuery1000 += queryTime1000;
        double updateTime1000 = [util updateData:1000];
        totalUpdate1000 += updateTime1000;
    }
    for (int i = 0; i < loop; i++) {
        double queryTime2000 = [util selectData:2000];
        totalQuery2000 += queryTime2000;
        double updateTime2000 = [util updateData:2000];
        totalUpdate2000 += updateTime2000;
    }
    for (int i = 0; i < loop; i++) {
        double queryTime4000 = [util selectData:4000];
        totalQuery4000 += queryTime4000;
        double updateTime4000 = [util updateData:4000];
        totalUpdate4000 += updateTime4000;
    }
    NSLog(@"query100:%f",totalQuery100/loop);
    NSLog(@"query500:%f",totalQuery500/loop);
    NSLog(@"query1000:%f",totalQuery1000/loop);
    NSLog(@"query2000:%f",totalQuery2000/loop);
    NSLog(@"query4000:%f",totalQuery4000/loop);

    NSLog(@"update100:%f",totalUpdate100/loop);
    NSLog(@"update500:%f",totalUpdate500/loop);
    NSLog(@"update1000:%f",totalUpdate1000/loop);
    NSLog(@"update2000:%f",totalUpdate2000/loop);
    NSLog(@"update4000:%f",totalUpdate4000/loop);
    
    double totalQueryAll = 0;
    for (int i = 0; i < loop; i++) {
        double queryAllTime = [util selectAll];
        totalQueryAll += queryAllTime;
    }
    NSLog(@"queryAll:%f",totalQueryAll/loop);
    
    [util deleteData:10000];
    
    //delete and insert
    double totalInsert100 = 0;
    double totalInsert500 = 0;
    double totalInsert1000 = 0;
    double totalInsert2000 = 0;
    double totalInsert4000 = 0;
    double totalInsertAll = 0;
    
    double totalDelete100 = 0;
    double totalDelete500 = 0;
    double totalDelete1000 = 0;
    double totalDelete2000 = 0;
    double totalDelete4000 = 0;
    double totalDeleteAll = 0;

    for (int i = 0; i < loop; i++) {
        double insertTime100 = [util insertData:100];
        totalInsert100 += insertTime100;
        double deleteTime100 = [util deleteData:100];
        totalDelete100 += deleteTime100;
    }
    for (int i = 0; i < loop; i++) {
        double insertTime500 = [util insertData:500];
        totalInsert500 += insertTime500;
        double deleteTime500 = [util deleteData:500];
        totalDelete500 += deleteTime500;
    }
    for (int i = 0; i < loop; i++) {
        double insertTime1000 = [util insertData:1000];
        totalInsert1000 += insertTime1000;
        double deleteTime1000 = [util deleteData:1000];
        totalDelete1000 += deleteTime1000;
    }
    for (int i = 0; i < loop; i++) {
        double insertTime2000 = [util insertData:2000];
        totalInsert2000 += insertTime2000;
        double deleteTime2000 = [util deleteData:2000];
        totalDelete2000 += deleteTime2000;
    }
    for (int i = 0; i < loop; i++) {
        double insertTime4000 = [util insertData:4000];
        totalInsert4000 += insertTime4000;
        double deleteTime4000 = [util deleteData:4000];
        totalDelete4000 += deleteTime4000;
    }
    for (int i = 0; i < loop; i++) {
        double insertTime10000 = [util insertData:10000];
        totalInsertAll += insertTime10000;
        double deleteTime10000 = [util deleteData:10000];
        totalDeleteAll += deleteTime10000;
    }
    NSLog(@"insert100:%f",totalInsert100/loop);
    NSLog(@"insert500:%f",totalInsert500/loop);
    NSLog(@"insert1000:%f",totalInsert1000/loop);
    NSLog(@"insert2000:%f",totalInsert2000/loop);
    NSLog(@"insert4000:%f",totalInsert4000/loop);
    NSLog(@"insertAll:%f",totalInsertAll/loop);
    
    NSLog(@"delete100:%f",totalDelete100/loop);
    NSLog(@"delete500:%f",totalDelete500/loop);
    NSLog(@"delete1000:%f",totalDelete1000/loop);
    NSLog(@"delete2000:%f",totalDelete2000/loop);
    NSLog(@"delete4000:%f",totalDelete4000/loop);
    NSLog(@"deleteAll:%f",totalDeleteAll/loop);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
