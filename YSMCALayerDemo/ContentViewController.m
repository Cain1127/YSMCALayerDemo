//
//  ContentViewController.m
//  YSMCALayerDemo
//
//  Created by ysmeng on 15/5/29.
//  Copyright (c) 2015年 广州七升网络科技有限公司. All rights reserved.
//

#import "ContentViewController.h"

#define PHOTO_HEIGHT 200.0f

@interface ContentViewController ()

@end

@implementation ContentViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    CALayer *layerShadow = [[CALayer alloc] init];
    layerShadow.bounds = CGRectMake(0.0f, 0.0f, PHOTO_HEIGHT, PHOTO_HEIGHT);
    layerShadow.position = CGPointMake(160.0f, 200.0f);
    layerShadow.cornerRadius = PHOTO_HEIGHT / 2.0f;
    layerShadow.shadowColor = [UIColor grayColor].CGColor;
    layerShadow.shadowOffset = CGSizeMake(2.0f, 1.0f);
    layerShadow.shadowOpacity = 1.0f;
    layerShadow.borderColor = [UIColor whiteColor].CGColor;
    layerShadow.borderWidth = 2.0f;
    [self.view.layer addSublayer:layerShadow];
    
    //自定义图层
    CALayer *layer = [[CALayer alloc] init];
    layer.bounds = CGRectMake(0.0f, 0.0f, PHOTO_HEIGHT, PHOTO_HEIGHT);
    layer.position = CGPointMake(160.0f, 200.0f);
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.cornerRadius = PHOTO_HEIGHT / 2.0f;
    
    //注意仅仅设置圆角，对于图形而言可以正常显示，但是对于图层中绘制的图片无法正确显示
    //如果想要正确显示则必须设置masksToBounds = YES，剪切子图层
    layer.masksToBounds = YES;
    
    //设置边框
    layer.borderColor = [UIColor whiteColor].CGColor;
    layer.borderWidth = 2.0f;
    
    //设置图片层
    UIImage *image = [UIImage imageNamed:@"icon_default.jpg"];
    [layer setContents:(id)image.CGImage];
    
    //添加图层到根图层
    [self.view.layer addSublayer:layer];
    
}

@end
