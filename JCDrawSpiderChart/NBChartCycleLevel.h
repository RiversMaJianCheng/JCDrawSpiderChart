//
//  NBChartCycleLevel.h
//  JJRadarChartSample
//
//  Created by newmac on 2017/9/11.
//  Copyright © 2017年 JeanLeo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NBChartCycleLevel;
/**
 *  数据源方法(必须实现)
 */
@protocol NBChartCycleLevelDataSource <NSObject>
@required
/**
 *  一共多少组数据
 *
 *  @param radarChart 控件本身
 *
 *  @return 组数
 */
- (NSInteger)numberOfItemsInRadarChart:(NBChartCycleLevel *)radarChart;
/**
 *  某一组最大数值(整形)
 *
 *  @param index      该组序号
 *  @param radarChart 控件本身
 *
 *  @return 数值
 */
- (NSInteger)radarChart:(NBChartCycleLevel *)radarChart maxCountAtIndex:(NSInteger)index;
@end

/**
 *  取半方法
 *
 *  @param floatValue 浮点型
 *
 *  @return 取半结果
 */
CGFloat half(CGFloat floatValue);

typedef void(^myBlockScore)(NSString *stringScore);//得分的block

@interface NBChartCycleLevel : UIControl

@property (nonatomic, strong) UILabel *labelCycleScoreTitle;

/**
 *  视图四周的label中的文字
 */
@property (nonatomic, strong) NSArray *arrayTitles;

/**
 *  回调到平均数
 */
@property (nonatomic, copy) myBlockScore block;
//数据源属性
@property (nonatomic, weak) id<NBChartCycleLevelDataSource>dataSource;

/**
 *  更新数据, 刷新视图
 */
- (void)reloadDataCurrentArray:(NSArray *)arrayValue;


@end
