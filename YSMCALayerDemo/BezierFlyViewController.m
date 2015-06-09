//
//  BezierFlyViewController.m
//  YSMCALayerDemo
//
//  Created by ysmeng on 15/5/30.
//  Copyright (c) 2015年 广州七升网络科技有限公司. All rights reserved.
//

#import "BezierFlyViewController.h"

@interface BezierFlyViewController ()

@property (nonatomic,strong) CALayer *flyLayer;

@end

@implementation BezierFlyViewController

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
    
    //2.设置路径
    
    //绘制贝塞尔曲线
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, self.flyLayer.position.x, self.flyLayer.position.y);
    
    //移动到起始点
    CGPathAddCurveToPoint(path, NULL, 160.0f, 280.0f, -30.0f, 300.0f, 55.0f, 400.0f);
    
    //绘制二次贝塞尔曲线
    keyframeAnimation.path = path;  //设置path属性
    CGPathRelease(path);            //释放路径对象
    
    //设置其他属性
    keyframeAnimation.duration = 8.0;
    keyframeAnimation.beginTime = CACurrentMediaTime()+1.0f;//设置延迟2秒执行
    
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
    
    ///4.添加动画到图层，注意key相当于给动画进行命名，以后获得该动画时可以使用此名称获取
    [self.flyLayer addAnimation:basicAnimation forKey:@"KCBasicAnimation_Rotation"];
    
}

@end
