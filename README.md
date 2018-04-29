# JCDrawSpiderChart

JCDrawSpiderChart是一个简单的动态网状图，不复杂可能计算麻烦点。
## 项目展示的效果如下：
下载项目后运行JCDrawSpiderDemo.xcodeproj
![](https://ws1.sinaimg.cn/large/006tNc79ly1fqtspbwkicg30850frjs1.gif)

## 安装
**CocoaPods**
1. 在Podfile文件中添加    pod 'JCDrawSpiderChart' , '~> 0.0.2'
2.  命令行执行 pod install 或 pod update
3. 导入 #import <NBChartCycleLevel.h>
**手动安装**
1. 下载项目后找到JCDrawSpiderChart文件夹
2. 将JCDrawSpiderChart文件夹加入或拖进你的工程项目
3. 导入#import "NBChartCycleLevel.h"

## 引入代码如下
```
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
```
## 许可证
JCDrawSpiderChart 使用MIT许可证，详情见LICENSE文件
