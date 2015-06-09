//
//  GroupAnimationViewController.m
//  YSMCALayerDemo
//
//  Created by ysmeng on 15/5/30.
//  Copyright (c) 2015年 广州七升网络科技有限公司. All rights reserved.
//

#import "GroupAnimationViewController.h"

@interface GroupAnimationViewController ()

@property (nonatomic,strong) CALayer *flyLayer;

@end

@implementation GroupAnimationViewController

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
    [self groupAnimation];
    
}

- (void)groupAnimation
{

    //1.创建动画组
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    
    //2.设置组中的动画和其他属性
    CABasicAnimation *basicAnimation = [self rotationAnimation];
    CAKeyframeAnimation *keyframeAnimation = [self translationAnimation];
    animationGroup.animations = @[basicAnimation,keyframeAnimation];
    animationGroup.delegate = self;
    animationGroup.duration = 10.0;
    
    //设置动画时间，如果动画组中动画已经设置过动画属性则不再生效
    animationGroup.beginTime = CACurrentMediaTime()+1.0f;//延迟1秒执行
    
    //3.给图层添加动画
    [self.flyLayer addAnimation:animationGroup forKey:nil];

}

#pragma mark - 基础旋转动画
- (CABasicAnimation *)rotationAnimation
{
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    CGFloat toValue = M_PI_2 * 3.0f;
    basicAnimation.toValue = [NSNumber numberWithFloat:M_PI_2 * 3.0f];
    
    basicAnimation.autoreverses = true;
    basicAnimation.repeatCount = HUGE_VALF;
    basicAnimation.removedOnCompletion = NO;
    [basicAnimation setValue:[NSNumber numberWithFloat:toValue] forKey:@"KCBasicAnimationProperty_ToValue"];
    
    return basicAnimation;

}

#pragma mark - 关键帧移动动画
- (CAKeyframeAnimation *)translationAnimation
{
    
    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGPoint endPoint = CGPointMake(55.0f, 400.0f);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, self.flyLayer.position.x, self.flyLayer.position.y);
    CGPathAddCurveToPoint(path, NULL, 160, 280, -30, 300, endPoint.x, endPoint.y);
    keyframeAnimation.path = path; CGPathRelease(path);
    
    [keyframeAnimation setValue:[NSValue valueWithCGPoint:endPoint] forKey:@"KCKeyframeAnimationProperty_EndPosition"];
    
    return keyframeAnimation;

}

#pragma mark - 动画完成
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
    CAAnimationGroup *animationGroup = (CAAnimationGroup *)anim;
    CABasicAnimation *basicAnimation = animationGroup.animations[0];
    CAKeyframeAnimation *keyframeAnimation = animationGroup.animations[1];
    CGFloat toValue = [[basicAnimation valueForKey:@"KCBasicAnimationProperty_ToValue"] floatValue];
    CGPoint endPoint = [[keyframeAnimation valueForKey:@"KCKeyframeAnimationProperty_EndPosition"] CGPointValue];
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    //设置动画最终状态
    self.flyLayer.position = endPoint;
    self.flyLayer.transform = CATransform3DMakeRotation(toValue, 0, 0, 1);
    [CATransaction commit];

}

@end
