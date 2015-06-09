//
//  TransitionViewController.m
//  YSMCALayerDemo
//
//  Created by ysmeng on 15/5/30.
//  Copyright (c) 2015年 广州七升网络科技有限公司. All rights reserved.
//

#import "TransitionViewController.h"

#define IMAGE_COUNT 3

@interface TransitionViewController ()

@property (nonatomic,strong) UIImageView *imageView;
@property (assign) NSInteger currentIndex;

@end

@implementation TransitionViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    /**
     *  1.创建转场动画
     
     *  2.设置转场类型、子类型（可选）及其他属性
     
     *  3.设置转场后的新视图并添加动画到图层
     
     *  下表列出了常用的转场类型(注意私有API是苹果官方没有公开的动画类型，但是目前通过仍然可以使用)：
     
     *  动画类型	说明	对应常量	是否支持方向设置
     *
     *  公开API
     *  fade	淡出效果	kCATransitionFade	是
     *  movein	新视图移动到旧视图上	kCATransitionMoveIn	是
     *  push	新视图推出旧视图	kCATransitionPush	是
     *  reveal	移开旧视图显示新视图	kCATransitionReveal	是
     *
     *  私有API	 	私有API只能通过字符串访问
     *  cube	立方体翻转效果	无	是
     *  oglFlip	翻转效果	无	是
     *  suckEffect	收缩效果	无	否
     *  rippleEffect	水滴波纹效果	无	否
     *  pageCurl	向上翻页效果	无	是
     *  pageUnCurl	向下翻页效果	无	是
     *  cameralIrisHollowOpen	摄像头打开效果	无	否
     *  cameraIrisHollowClose	摄像头关闭效果	无	否
     *  另外对于支持方向设置的动画类型还包含子类型：
     
     *  动画子类型	说明
     *  kCATransitionFromRight	从右侧转场
     *  kCATransitionFromLeft	从左侧转场
     *  kCATransitionFromTop	从顶部转场
     *  kCATransitionFromBottom	从底部转场
     *
     */
    
    //定义图片控件
    _imageView = [[UIImageView alloc]init];
    _imageView.frame = [UIScreen mainScreen].applicationFrame;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.image = [UIImage imageNamed:@"group_01.jpg"];//默认图片
    
    [self.view addSubview:_imageView];
    
    //添加手势
    UISwipeGestureRecognizer *leftSwipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipe:)];
    leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftSwipeGesture];
    
    UISwipeGestureRecognizer *rightSwipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipe:)];
    rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipeGesture];
    
}

#pragma mark 向左滑动浏览下一张图片
- (void)leftSwipe:(UISwipeGestureRecognizer *)gesture
{
    
    [self transitionAnimation:YES];

}

#pragma mark 向右滑动浏览上一张图片
- (void)rightSwipe:(UISwipeGestureRecognizer *)gesture
{
    
    [self transitionAnimation:NO];

}

#pragma mark 转场动画
- (void)transitionAnimation:(BOOL)isNext
{
    
    //1.创建转场动画对象
    CATransition *transition = [[CATransition alloc]init];
    
    //2.设置动画类型,注意对于苹果官方没公开的动画类型只能使用字符串，并没有对应的常量定义
    transition.type = @"cube";
    
    //设置子类型
    if (isNext) {
        
        transition.subtype = kCATransitionFromRight;
    
    } else {
        
        transition.subtype = kCATransitionFromLeft;
    
    }
    
    //设置动画时常
    transition.duration = 1.0f;
    
    //3.设置转场后的新视图添加转场动画
    _imageView.image = [self getImage:isNext];
    [_imageView.layer addAnimation:transition forKey:@"KCTransitionAnimation"];

}

#pragma mark 取得当前图片
- (UIImage *)getImage:(BOOL)isNext
{
    
    if (isNext) {
        
        _currentIndex = (_currentIndex + 1) % IMAGE_COUNT;
    
    } else {
        
        _currentIndex = (_currentIndex - 1 + IMAGE_COUNT) % IMAGE_COUNT;
    
    }
    
    NSString *imageName = [NSString stringWithFormat:@"group_0%d.jpg",_currentIndex + 1];
    return [UIImage imageNamed:imageName];

}

@end
