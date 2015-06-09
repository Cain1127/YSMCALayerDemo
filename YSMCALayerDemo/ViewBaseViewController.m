//
//  ViewBaseViewController.m
//  YSMCALayerDemo
//
//  Created by ysmeng on 15/5/30.
//  Copyright (c) 2015年 广州七升网络科技有限公司. All rights reserved.
//

#import "ViewBaseViewController.h"

//#define ___BASE_ANIMATION___

@interface ViewBaseViewController ()

@property (nonatomic,strong) UIImageView *imageView;

@end

@implementation ViewBaseViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    //创建图像显示控件
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bounce_ball.png"]];
    _imageView.center = CGPointMake(50.0f, 150.0f);
    [self.view addSubview:_imageView];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = touches.anyObject;
    CGPoint location = [touch locationInView:self.view];
    
#ifdef ___BASE_ANIMATION___
    [UIView beginAnimations:@"KCBasicAnimation" context:nil];
    [UIView setAnimationDuration:5.0];
    
    _imageView.center = location;
    
    //开始动画
    [UIView commitAnimations];
#else
    /*  
     *  创建弹性动画
     *  damping:阻尼，范围0-1，阻尼越接近于0，弹性效果越明显
     *  velocity:弹性复位的速度
     *
     */
    [UIView animateWithDuration:5.0 delay:0 usingSpringWithDamping:0.1 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        _imageView.center = location;
    
    } completion:nil];
#endif
    
}

@end
