//
//  DelegateDrawViewController.m
//  YSMCALayerDemo
//
//  Created by ysmeng on 15/5/28.
//  Copyright (c) 2015年 广州七升网络科技有限公司. All rights reserved.
//

#import "DelegateDrawViewController.h"

#define PHOTO_HEIGHT 200.0f

@interface DelegateDrawViewController ()

@end

@implementation DelegateDrawViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    //自定义图层
    CALayer *layer = [[CALayer alloc] init];
    layer.bounds = CGRectMake(0.0f, 0.0f, PHOTO_HEIGHT, PHOTO_HEIGHT);
    layer.position = CGPointMake(160.0f, 200.0f);
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.cornerRadius = PHOTO_HEIGHT / 2.0f;
    
    //注意仅仅设置圆角，对于图形而言可以正常显示，但是对于图层中绘制的图片无法正确显示
    //如果想要正确显示则必须设置masksToBounds = YES，剪切子图层
    layer.masksToBounds = YES;
    
    //阴影效果无法和masksToBounds同时使用，因为masksToBounds的目的就是剪切外边框，
    //而阴影效果刚好在外边框
//    layer.shadowColor = [UIColor grayColor].CGColor;
//    layer.shadowOffset = CGSizeMake(2, 2);
//    layer.shadowOpacity = 1;
    
    //设置边框
    layer.borderColor = [UIColor whiteColor].CGColor;
    layer.borderWidth = 2.0f;
    
    //设置图层代理
    layer.delegate = self;
    
    //添加图层到根图层
    [self.view.layer addSublayer:layer];
    
    //调用图层setNeedDisplay,否则代理方法不会被调用
    [layer setNeedsDisplay];
    
}

#pragma mark - 绘制图形、图像到图层
///注意参数中的ctx是图层的图形上下文，其中绘图位置也是相对图层而言的
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    
    //这个图层正是上面定义的图层
    CGContextSaveGState(ctx);
    
    //图形上下文形变，解决图片倒立的问题
    CGContextScaleCTM(ctx, 1.0f, -1.0f);
    CGContextTranslateCTM(ctx, 0.0f, -PHOTO_HEIGHT);
    
    UIImage *image = [UIImage imageNamed:@"icon_default.jpg"];
    
    //注意这个位置是相对于图层而言的不是屏幕
    CGContextDrawImage(ctx, CGRectMake(0.0f, 0.0f, PHOTO_HEIGHT, PHOTO_HEIGHT), image.CGImage);
    
    CGContextRestoreGState(ctx);

}

@end
