//
//  ViewAniminationViewController.m
//  YSMCALayerDemo
//
//  Created by ysmeng on 15/5/29.
//  Copyright (c) 2015年 广州七升网络科技有限公司. All rights reserved.
//

#import "ViewAniminationViewController.h"

@interface ViewAniminationViewController ()

@end

@implementation ViewAniminationViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    UIImage *image = [UIImage imageNamed:@"icon_default.jpg"];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    imageView.frame = CGRectMake(120.0f, 140.0f, 80.0f, 80.0f);
    [self.view addSubview:imageView];
    
    //两秒后开始一个持续一分钟的动画
    [UIView animateWithDuration:1.0f delay:1.0f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        imageView.frame = CGRectMake(80.0f, 100.0f, 160.0f, 160.0f);
    
    } completion:nil];
    
}

@end
