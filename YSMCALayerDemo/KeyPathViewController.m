//
//  KeyPathViewController.m
//  YSMCALayerDemo
//
//  Created by ysmeng on 15/5/30.
//  Copyright (c) 2015年 广州七升网络科技有限公司. All rights reserved.
//

#import "KeyPathViewController.h"

@interface KeyPathViewController ()

@property (nonatomic,strong) CALayer *flyLayer;

@end

@implementation KeyPathViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    //设置背景(注意这个图片其实在根图层)
    UIImage *backgroundImage = [UIImage imageNamed:@"bg_default.jpg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    
    //自定义一个图层
    self.flyLayer = [[CALayer alloc] init];
    self.flyLayer.bounds = CGRectMake(0.0f, 0.0f, 30.0f, 18.0f);
    self.flyLayer.position = CGPointMake(50.0f, 150.0f);
    self.flyLayer.contents = (id)[UIImage imageNamed:@"leave_default.png"].CGImage;
    [self.view.layer addSublayer:self.flyLayer];
    
    //创建动画
    [self translationAnimation];
    [self rotationAnimation];
    
}

#pragma mark - 关键帧动画
- (void)translationAnimation
{
    
    //1.创建关键帧动画并设置动画属性
    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    //2.设置关键帧,这里有四个关键帧
    NSValue *key1 = [NSValue valueWithCGPoint:self.flyLayer.position];
    
    //对于关键帧动画初始值不能省略
    NSValue *key2 = [NSValue valueWithCGPoint:CGPointMake(80.0f, 220.0f)];
    NSValue *key3 = [NSValue valueWithCGPoint:CGPointMake(45.0f, 300.0f)];
    NSValue *key4 = [NSValue valueWithCGPoint:CGPointMake(55.0f, 400.0f)];
    NSArray *values = @[key1,key2,key3,key4];
    keyframeAnimation.values = values;
    
    /**
     *  keyTimes：各个关键帧的时间控制。前面使用values设置了四个关键帧，默认情况下每两帧之间的间隔为:8/(4-1)秒。如果想要控制 动画从第一帧到第二针占用时间4秒，从第二帧到第三帧时间为2秒，而从第三帧到第四帧时间2秒的话，就可以通过keyTimes进行设置。 keyTimes中存储的是时间占用比例点，此时可以设置keyTimes的值为0.0，0.5，0.75，1.0（当然必须转换为NSNumber）， 也就是说1到2帧运行到总时间的50%，2到3帧运行到总时间的75%，3到4帧运行到8秒结束。
     
     *  caculationMode：动画计算模式。还拿上面keyValues动画举例，之所以1到2帧能形成连贯性动画而不是直接从第1帧经过8/3 秒到第2帧是因为动画模式是连续的（值为kCAAnimationLinear，这是计算模式的默认值）；而如果指定了动画模式为 kCAAnimationDiscrete离散的那么你会看到动画从第1帧经过8/3秒直接到第2帧，中间没有任何过渡。其他动画模式还 有：kCAAnimationPaced（均匀执行，会忽略keyTimes）、kCAAnimationCubic（平滑执行，对于位置变动关键帧动画 运行轨迹更平滑）、kCAAnimationCubicPaced（平滑均匀执行）。
     */
    
    //设置其他属性
    keyframeAnimation.duration = 8.0;
    keyframeAnimation.beginTime= CACurrentMediaTime() + 1.0f;//设置延迟1秒执行
    
    //3.添加动画到图层，添加动画后就会执行动画
    [self.flyLayer addAnimation:keyframeAnimation forKey:@"KCKeyframeAnimation_Position"];

}

#pragma mark - 旋转动画
-(void)rotationAnimation
{
    
    //1.创建动画并指定动画属性
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    //2.设置动画属性初始值、结束值
    
    //    basicAnimation.fromValue = [NSNumber numberWithInt:M_PI_2];
    basicAnimation.toValue=[NSNumber numberWithFloat:M_PI_2 * 3.0f];
    
    //设置其他动画属性
    basicAnimation.duration = 3.0;
    basicAnimation.autoreverses = true;
    basicAnimation.beginTime = CACurrentMediaTime() + 1.0f;
    
    //旋转后在旋转到原来的位置
    basicAnimation.repeatCount = 1;
    
    //设置无限循环
    basicAnimation.removedOnCompletion = NO;
//    basicAnimation.delegate = self;
    
    ///4.添加动画到图层，注意key相当于给动画进行命名，以后获得该动画时可以使用此名称获取
    [self.flyLayer addAnimation:basicAnimation forKey:@"KCBasicAnimation_Rotation"];
    
}

@end
