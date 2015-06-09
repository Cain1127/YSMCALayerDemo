//
//  ViewController.m
//  YSMCALayerDemo
//
//  Created by ysmeng on 15/5/28.
//  Copyright (c) 2015年 广州七升网络科技有限公司. All rights reserved.
//

#import "ViewController.h"

#define WIDTH_DEFAULT 120.0f

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    [self drawMyLayer];
    
}

- (void)drawMyLayer
{

    CGSize size = [UIScreen mainScreen].bounds.size;
    
    //获得根图层
    CALayer *layer = [[CALayer alloc] init];
    
    //设置背景颜色,由于QuartzCore是跨平台框架，无法直接使用UIColor
    layer.backgroundColor = [UIColor colorWithRed:0.0f green:146.0f / 255.0f blue:1.0 alpha:1.0].CGColor;
    
    //设置中心点
    layer.position = CGPointMake(size.width/2.0f, size.height/2.0f);
    
    //设置大小
    layer.bounds = CGRectMake(0, 0, WIDTH_DEFAULT,WIDTH_DEFAULT);
    
    //设置圆角,当圆角半径等于矩形的一半时看起来就是一个圆形
    layer.cornerRadius = WIDTH_DEFAULT / 2.0f;
    
    //设置阴影
    layer.shadowColor = [UIColor grayColor].CGColor;
    layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
    layer.shadowOpacity = 0.9f;
    
    //设置边框
//    layer.borderColor = [UIColor whiteColor].CGColor;
//    layer.borderWidth = 1;
    
    //设置锚点
//    layer.anchorPoint = CGPointZero;
    
    [self.view.layer addSublayer:layer];

}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [touches anyObject];
    NSArray *layers = self.view.layer.sublayers;
    CALayer *layer = layers[2];
    CGFloat width = layer.bounds.size.width;
    if (width == WIDTH_DEFAULT) {
        
        width = WIDTH_DEFAULT * 2.0f;
        
    } else {
        
        width = WIDTH_DEFAULT;
        
    }
    
    layer.bounds = CGRectMake(0.0f, 0.0f, width, width);
    layer.position = [touch locationInView:self.view];
    layer.cornerRadius = width / 2.0f;

}

@end
