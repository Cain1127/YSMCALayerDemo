//
//  CATapFlyViewController.m
//  YSMCALayerDemo
//
//  Created by ysmeng on 15/5/29.
//  Copyright (c) 2015年 广州七升网络科技有限公司. All rights reserved.
//

#import "CATapFlyViewController.h"

@interface CATapFlyViewController ()

@property (nonatomic,strong) CALayer *flyLayer;

@end

@implementation CATapFlyViewController

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
    
}

#pragma mark - 移动动画
- (void)translatonAnimation:(CGPoint)location
{
    
    //1.创建动画并指定动画属性
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    
    //2.设置动画属性初始值和结束值
//    basicAnimation.fromValue = [NSNumber numberWithInteger:50];
    //可以不设置，默认为图层初始状态
    basicAnimation.toValue = [NSValue valueWithCGPoint:location];
    
    //设置其他动画属性
    basicAnimation.duration = 3.0;//动画时间5秒
//    basicAnimation.repeatCount = HUGE_VALF;
    
    //设置重复次数,HUGE_VALF可看做无穷大，起到循环动画的效果
//    basicAnimation.removedOnCompletion = NO;
    
    ///动画代理
    basicAnimation.delegate = self;
    
    //存储当前位置在动画结束后使用
    [basicAnimation setValue:[NSValue valueWithCGPoint:location] forKey:@"KCBasicAnimationLocation"];
    
    //运行一次是否移除动画
    
    //3.添加动画到图层，注意key相当于给动画进行命名，以后获得该动画时可以使用此名称获取
    [self.flyLayer addAnimation:basicAnimation forKey:@"KCBasicAnimation_Translation"];

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
    basicAnimation.duration = 6.0;
    basicAnimation.autoreverses = true;
    
    //旋转后在旋转到原来的位置
    basicAnimation.repeatCount = HUGE_VALF;
    
    //设置无限循环
    basicAnimation.removedOnCompletion = NO;
//    basicAnimation.delegate = self;
    
    ///4.添加动画到图层，注意key相当于给动画进行命名，以后获得该动画时可以使用此名称获取
    [self.flyLayer addAnimation:basicAnimation forKey:@"KCBasicAnimation_Rotation"];

}

#pragma mark - 点击事件
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = touches.anyObject;
    CGPoint location = [touch locationInView:self.view];
    
    //判断是否已经常见过动画，如果已经创建则不再创建动画
    CAAnimation *animation = [self.flyLayer animationForKey:@"KCBasicAnimation_Translation"];
    if(animation) {
        
        if (self.flyLayer.speed == 0) {
            
            [self animationResume];
        
        } else {
            
            [self animationPause];
        
        }
    
    } else {
        
        //创建并开始动画
        [self translatonAnimation:location];
        [self rotationAnimation];
    
    }

}

#pragma mark - 动画暂停
- (void)animationPause
{
    
    //取得指定图层动画的媒体时间，后面参数用于指定子图层，这里不需要
    CFTimeInterval interval = [self.flyLayer convertTime:CACurrentMediaTime() fromLayer:nil];
    
    //设置时间偏移量，保证暂停时停留在旋转的位置
    [self.flyLayer setTimeOffset:interval];
    
    //速度设置为0，暂停动画
    self.flyLayer.speed=0;

}

#pragma mark - 动画恢复
-(void)animationResume
{
    
    //获得暂停的时间
    CFTimeInterval beginTime = CACurrentMediaTime() - self.flyLayer.timeOffset;
    
    //设置偏移量
    self.flyLayer.timeOffset = 0;
    
    //设置开始时间
    self.flyLayer.beginTime = beginTime;
    
    //设置动画速度，开始运动
    self.flyLayer.speed = 1.0;

}

#pragma mark - 动画结束
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
    //开启事务
    [CATransaction begin];
    
    //禁用隐式动画
    [CATransaction setDisableActions:YES];
    self.flyLayer.position = [[anim valueForKey:@"KCBasicAnimationLocation"] CGPointValue];
    
    //提交事务
    [CATransaction commit];
    
    //暂停动画
    [self animationPause];

}

@end
