//
//  ViewController.m
//  JCDrawSpiderDemo
//
//  Created by tanmin on 2018/4/29.
//  Copyright © 2018年 tanmin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NBChartCycleLevel *cycleLevelChart;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   [self.view addSubview:self.cycleLevelChart];
}
    
- (NBChartCycleLevel *)cycleLevelChart {
    
    if (!_cycleLevelChart) {
        //根据frame创建雷达图表
        _cycleLevelChart = [[NBChartCycleLevel alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.width)];
    }
    return _cycleLevelChart;
}


@end
