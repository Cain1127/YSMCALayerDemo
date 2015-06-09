//
//  YSMLayer.m
//  YSMCALayerDemo
//
//  Created by ysmeng on 15/5/29.
//  Copyright (c) 2015年 广州七升网络科技有限公司. All rights reserved.
//

#import "YSMLayer.h"

@implementation YSMLayer

- (void)drawInContext:(CGContextRef)ctx
{

    CGContextSetRGBFillColor(ctx, 135.0 / 255.0, 232.0 / 255.0, 84.0 / 255.0, 1);
    CGContextSetRGBStrokeColor(ctx, 135.0 / 255.0, 232.0 / 255.0, 84.0 / 255.0, 1);
    
    CGContextMoveToPoint(ctx, 94.5, 33.5);
    
    //// Star Drawing
    CGContextAddLineToPoint(ctx,104.02, 47.39);
    CGContextAddLineToPoint(ctx,120.18, 52.16);
    CGContextAddLineToPoint(ctx,109.91, 65.51);
    CGContextAddLineToPoint(ctx,110.37, 82.34);
    CGContextAddLineToPoint(ctx,94.5, 76.7);
    CGContextAddLineToPoint(ctx,78.63, 82.34);
    CGContextAddLineToPoint(ctx,79.09, 65.51);
    CGContextAddLineToPoint(ctx,68.82, 52.16);
    CGContextAddLineToPoint(ctx,84.98, 47.39);
    CGContextClosePath(ctx);
    
    CGContextDrawPath(ctx, kCGPathFillStroke);

}

@end
