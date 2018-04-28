//
//  NBChartCycleLevel.m
//  JJRadarChartSample
//
//  Created by newmac on 2017/9/11.
//  Copyright © 2017年 JeanLeo. All rights reserved.
//

#import "NBChartCycleLevel.h"

CGFloat half(CGFloat floatValue) {
    return floatValue * 0.5;
}

UIColor* colorRGB(CGFloat r, CGFloat g, CGFloat b) {
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
}

@interface NBChartCycleLevel () {
    NSInteger _itemsNumber;             //一共模拟的组数
    NSMutableArray *_arrayMaxCounts;    //每组的最大数据暂定都是100。
    NSArray *_arrayRanks;               //每组的具体数值
    NSMutableArray *_myPoint;           //存储点的位置数组
    CGFloat labelWith;                  //四周label的宽高
    CGContextRef ctx;                   //上下文
    CGFloat maxRadius;                  //半径
    NSMutableArray *_arrayMyLabels;     //这里存储四周的label视图
    NSString *stringScore;              //平均分数
    NSMutableArray *_arrayPoints;
}
@end

@implementation NBChartCycleLevel

#pragma mark - struct

- (instancetype)initWithFrame:(CGRect)frame {
    
    if ( self = [super initWithFrame:frame]) {
        [self creatSubViews];
        [self reloadDataCurrentArray:nil];
    }
    return self;
}

- (void)creatSubViews{
    //初始化一些数据
    _arrayMyLabels = [NSMutableArray array];//这里存储四周的label视图
    self.backgroundColor = [UIColor clearColor];
    
    
    //骑行得分
    [self addSubview:self.labelCycleScoreTitle];
    maxRadius = half(self.frame.size.height) * 0.5;//高度一半的0.5倍
    labelWith = half(self.frame.size.height) * 0.35;//高度一半的0.35倍
    
    _arrayMaxCounts = [NSMutableArray array];   //每组的最大数据
    _itemsNumber = 0;//一共模拟的组数
    
    //调用代理方法返回一共模拟的组数
    if ([_dataSource respondsToSelector:@selector(numberOfItemsInRadarChart:)]) {
        _itemsNumber = [_dataSource numberOfItemsInRadarChart:self];//返回组数
    }else{
        _itemsNumber = 5;
    }
    
    if ([_dataSource respondsToSelector:@selector(radarChart:maxCountAtIndex:)]) {
        for (NSInteger i = 0; i < _itemsNumber; i++) {
            NSNumber *maxCount = @([_dataSource radarChart:self maxCountAtIndex:i]);
            [_arrayMaxCounts addObject:maxCount];//返回每组的最大值
        }
    }else{
        _arrayMaxCounts = [NSMutableArray arrayWithArray:@[@100,@100,@100,@100,@100]];
    }
    
    //默认给labelTitles的值
    self.arrayTitles = @[@"攻击能力",@"躲避能力",@"防御能力",@"逃跑能力",@"飞跃能力"];
}

#pragma mark - setter
- (void)setDataSource:(id<NBChartCycleLevelDataSource>)dataSource {
    _dataSource = dataSource;
}
#pragma mark - superMethod

- (void)drawRect:(CGRect)rect {
    CGFloat margin = maxRadius / 5;//线条之间的间隙,这就保证了值是40-100之间
    //这里为了获取最外侧label的值 用来确定label的位置
    //for循环创建
    for (int i = 0; i < 4; i++) {
           [self drawPolygonWithRadius:maxRadius - (i * margin) index:i];
    }
    if (_arrayRanks.count > 0) {
        [self drawLine];//画动图
    }
}
- (UILabel *)labelCycleScoreTitle{
    if (!_labelCycleScoreTitle) {
        _labelCycleScoreTitle = [[UILabel alloc] init];
        _labelCycleScoreTitle.frame = CGRectMake(10.f, 15.f , self.frame.size.width - 20.0, 30.f);
        _labelCycleScoreTitle.text = @"我的数据";
        _labelCycleScoreTitle.font = [UIFont boldSystemFontOfSize:20.f];
        _labelCycleScoreTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _labelCycleScoreTitle;
}

//调用此方法刷新数据，外部调用
- (void)reloadDataCurrentArray:(NSArray *)arrayValue {
    [self resetData:arrayValue];
    [self setNeedsDisplay];
}
#pragma mark - function
- (void)resetData: (NSArray *)arrayValue{
    
    _arrayRanks = [NSMutableArray array];       //每组的具体数值
    _myPoint = [NSMutableArray array];          //我的当前点数组
    if (arrayValue != nil) {
        _arrayRanks = arrayValue;
    }else{
        if (@available(iOS 10.0, *)) {
            [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
                NSMutableArray *arrayMutable = [NSMutableArray array];
                for (int i = 0; i < 5; i++) {
                    NSNumber *index = @(40 + arc4random() % 60) ;
                    [arrayMutable addObject:index];
                }
                self->_arrayRanks = arrayMutable;
                [self setNeedsDisplay];
            }];
        } else {
            // Fallback on earlier versions
        }
    }
}

//画蜘蛛网四周的线
- (void)drawPolygonWithRadius:(CGFloat)radius index:(NSInteger )index{
    
    @autoreleasepool {
    //获取上下文
    NSInteger num = _itemsNumber;
    // 以下x，y是中心点
    CGFloat x = half(self.frame.size.width);
    CGFloat y = half(self.frame.size.height);
    ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(ctx, 0.5, 0.5, 0.5, 1.0);//画线的颜色
    CGContextSetLineWidth(ctx, 1); //画线的宽度
    CGContextMoveToPoint(ctx,  x + radius * cos(1.5*M_PI - 2.0*M_PI/num), y + radius * sin(1.5*M_PI - 2.0*M_PI/num));
    NSMutableArray *topPionts = [NSMutableArray array];//加入点的位置
    for (NSInteger i = 0; i < num; i++) {
        //计算顶点的位置，总共是2π
        CGPoint point = CGPointMake(x + radius * cos( 2 * M_PI * i / num + 1.5*M_PI), y + radius * sin(2 * M_PI * i / num + 1.5*M_PI));//5个值从-0.5π开始画
        
        [topPionts addObject:[NSValue valueWithCGPoint:point]];
        if (index == 0) {
            //记录四周label中心点的位置，这里用最外侧值半径的1.5倍为中心点
            CGPoint mypoint = CGPointMake(x + radius*1.5 * cos( 2 * M_PI * i / num + 1.5*M_PI ), y + radius * 1.5 * sin(2 * M_PI * i / num + 1.5*M_PI ));//5个值从-0.5π开始画
            [_myPoint addObject:[NSValue valueWithCGPoint:mypoint]];
        }
        //连线
        CGContextAddLineToPoint(ctx, point.x, point.y);
    }
    CGContextStrokePath(ctx);//只要路径就行
    
    //这里进行判断如果label创建了就不需要每次再创建了
    if (_arrayMyLabels.count == 0) {
        [self creatLabels];
    }
 }
}

- (void)creatLabels{
      //创建最外侧的几个Lable
    for (NSInteger i = 0; i < _itemsNumber; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelWith + 35 , labelWith)];
        NSValue *pValue = _myPoint[i];
        CGPoint bCenter = pValue.CGPointValue;
        label.textAlignment = NSTextAlignmentCenter;
        label.center = bCenter;
        label.numberOfLines = 0;
        label.text = self.arrayTitles[i];
        [_arrayMyLabels addObject:label];//创建5个label加进去
        if (_arrayMyLabels.count > 0) {
            [self addSubview:_arrayMyLabels[i]];
        }
    }

}

- (void)drawLine {
    
 @autoreleasepool {
    CGFloat radius;
    NSInteger num = _itemsNumber;
    CGFloat x = half(self.frame.size.width);
    CGFloat y = half(self.frame.size.height);
    ctx = UIGraphicsGetCurrentContext();
    [colorRGB(14, 39, 44) setFill];//中间视图的背景
    CGContextSetAlpha(ctx, 0.7);
    radius = maxRadius / ((NSNumber *)_arrayMaxCounts.lastObject).integerValue * ((NSNumber *)_arrayRanks.lastObject).integerValue;
    CGContextMoveToPoint(ctx,  x + radius * cos(1.5*M_PI - 2.0*M_PI/num), y + radius * sin(1.5*M_PI - 2.0*M_PI/num));
    
    _arrayPoints = [NSMutableArray array];
    for (NSInteger i = 1; i <= num; i++) {
        radius = maxRadius / ((NSNumber *)_arrayMaxCounts[i - 1]).integerValue * ((NSNumber *)_arrayRanks[i - 1]).integerValue;
        //计算当前点的位置
        CGPoint point = CGPointMake(x + radius * cos( 2 * M_PI * i / num + 1.5*M_PI - 2.0*M_PI/num), y + radius * sin(2 * M_PI * i / num + 1.5*M_PI - 2.0*M_PI/num));//5个值从-0.5π开始画
        //点的位置要内收
        CGPoint mypoint = CGPointMake(x + (radius-3) * cos( 2 * M_PI * i / num + 1.5*M_PI - 2.0*M_PI/num), y + (radius-3) * sin(2 * M_PI * i / num + 1.5*M_PI - 2.0*M_PI/num));//5个值从-0.5π开始画
        [_arrayPoints addObject:[NSValue valueWithCGPoint:mypoint]];
        
        //连线
        CGContextAddLineToPoint(ctx, point.x, point.y);
    }
    CGContextFillPath(ctx);
    
    {
        for (int i = 0; i < _arrayPoints.count; i++) {
            
            // 获取图形上下文
            CGContextRef ctx1 = UIGraphicsGetCurrentContext();
            CGFloat width = 5;
            /**
             画实心圆
             */
            NSValue *pValue = _arrayPoints[i];
            CGPoint bCenter = pValue.CGPointValue;
            CGRect frame = CGRectMake(bCenter.x - 2.5, bCenter.y - 2.5,width,width);
            //设置空心圆的线条宽度
            CGContextSetLineWidth(ctx1, 1);
            //以矩形bigRect为依据画一个圆
            CGContextAddEllipseInRect(ctx1, frame);
            //填充当前绘画区域的颜色
            [[UIColor whiteColor] set];
            //(如果是画圆会沿着矩形外围描画出指定宽度的（圆线）空心圆)/（根据上下文的内容渲染图层）
            CGContextStrokePath(ctx1);
            
            //填充颜色
            [[UIColor blackColor] setFill];
            //以矩形frame为依据画一个圆
            CGContextAddEllipseInRect(ctx1, frame);
            CGContextFillPath(ctx1);
        }
    }
//    self.block(stringScore);
 }
}


@end
