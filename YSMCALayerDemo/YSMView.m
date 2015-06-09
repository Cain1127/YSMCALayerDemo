//
//  YSMView.m
//  YSMCALayerDemo
//
//  Created by ysmeng on 15/5/29.
//  Copyright (c) 2015年 广州七升网络科技有限公司. All rights reserved.
//

#import "YSMView.h"
#import "YSMLayer.h"

@implementation YSMView

- (instancetype)initWithFrame:(CGRect)frame
{

    if (self = [super initWithFrame:frame]) {
        
        YSMLayer *myLayer = [[YSMLayer alloc] init];
        myLayer.bounds=CGRectMake(0, 0, 185, 185);
        myLayer.position=CGPointMake(160,284);
        myLayer.backgroundColor=[UIColor colorWithRed:0 green:146/255.0 blue:1.0 alpha:1.0].CGColor;
        
        //显示图层
        [myLayer setNeedsDisplay];
        [self.layer addSublayer:myLayer];
        
    }
    
    return self;

}

@end
