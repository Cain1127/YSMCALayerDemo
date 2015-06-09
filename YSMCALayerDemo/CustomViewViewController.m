//
//  CustomViewViewController.m
//  YSMCALayerDemo
//
//  Created by ysmeng on 15/5/29.
//  Copyright (c) 2015年 广州七升网络科技有限公司. All rights reserved.
//

#import "CustomViewViewController.h"
#import "YSMView.h"

@interface CustomViewViewController ()

@end

@implementation CustomViewViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    YSMView *view = [[YSMView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor colorWithRed:249.0/255.0 green:249.0/255.0 blue:249.0/255.0 alpha:1];
    [self.view addSubview:view];
    
}

@end
