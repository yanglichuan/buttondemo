//
//  HMViewController.m
//  02-按钮操作
//
//  Created by apple on 14-8-11.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "HMViewController.h"

// 枚举类型本质上就是整数，定义的时候，如果只指定了第一个数值，后续的数值会依次递增
// 枚举类型是解决魔法数字比较常用的手段
typedef enum {
    kMovingDirTop = 10,
    kMovingDirBottom,
    kMovingDirLeft,
    kMovingDirRight,
} kMovingDir;

#define kMovingDelta    20.0f

@interface HMViewController ()
@property (weak, nonatomic) IBOutlet UIButton *iconButton;

// 每次的形变累加
@property (nonatomic, assign) CGFloat delta;
@end

@implementation HMViewController

/** 加载完成被调用 */
- (void)viewDidLoad
{
    // 千万不要忘记调用父类的实现方法
    [super viewDidLoad];
    
    // 用代码创建按钮
    // 使用alloc init方法实例化的按钮，就是custom类型的，按钮的类型一旦指定，不能修改
    // 如果创建其他类型的按钮
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn1.center = CGPointMake(20, 40);
    [self.view addSubview:btn1];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(110, 300, 100, 100)];
    self.iconButton = btn;
    
    btn.backgroundColor = [UIColor redColor];
    
    // 设置背景图片
    [btn setBackgroundImage:[UIImage imageNamed:@"btn_01"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"btn_02"] forState:UIControlStateHighlighted];
    
    // 设置按钮文字
    [btn setTitle:@"点我啊" forState:UIControlStateNormal];
    [btn setTitle:@"摸我" forState:UIControlStateHighlighted];
    
    // 设置文字颜色
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    
    // 文字垂直对齐方式
    btn.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    
    // 将按钮添加到视图
    [self.view addSubview:btn];
}

#pragma mark - 操作
- (IBAction)move1:(UIButton *)button
{
//    self.delta -= 20.0;
//    // CGAffineTransformMakeTranslation的位移形变是相对按钮"初始"位置来变化的
//    self.iconButton.transform = CGAffineTransformMakeTranslation(0, self.delta);
    // CGAffineTransformTranslate 的位移形变是对按钮的上次形变的累加
    
    CGFloat dx = 0, dy = 0;
    if (button.tag == kMovingDirTop || button.tag == kMovingDirBottom) {
        dy = (button.tag == kMovingDirTop) ? -kMovingDelta : kMovingDelta;
    }
    if (button.tag == kMovingDirLeft || button.tag == kMovingDirRight) {
        dx = (button.tag == kMovingDirLeft) ? -kMovingDelta : kMovingDelta;
    }
    
//    switch (button.tag) {
//        case kMovingDirTop:        // 上
//            dy = -20;
//            break;
//        case kMovingDirBottom:        // 下
//            dy = 20;
//            break;
//        case kMovingDirLeft:        // 左
//            dx = -20;
//            break;
//        case kMovingDirRight:        // 右
//            dx = 20;
//            break;
//    }
    
    self.iconButton.transform = CGAffineTransformTranslate(self.iconButton.transform, dx, dy);
    
    NSLog(@"%@", NSStringFromCGAffineTransform(self.iconButton.transform));
}

/**
 frame属性，通常用于实例化控件，指定初始位置
 
 如果需要改变控件位置，可以使用center属性
 如果需要改变控件大小，可以使用bounds属性
 */
- (IBAction)move:(UIButton *)button
{
    // 提示，也可以通过center修改位置，可以课后练习
    CGPoint center = self.iconButton.center;
    
    // 2. 根据按钮的类型tag，判断移动的方向，再修改结构体的成员
    // magic number魔法数字
    switch (button.tag) {
        case kMovingDirTop:        // 上
            center.y -= kMovingDelta;
            break;
        case kMovingDirBottom:        // 下
            center.y += kMovingDelta;
            break;
        case kMovingDirLeft:        // 左
            center.x -= kMovingDelta;
            break;
        case kMovingDirRight:        // 右
            center.x += kMovingDelta;
            break;
    }
    
    // 3. 重新为对象的结构体属性赋值
    self.iconButton.center = center;
    
    NSLog(@"%@", NSStringFromCGRect(self.iconButton.frame));
}


/** 放大缩小 */
- (IBAction)zoom:(UIButton *)button
{
    CGFloat scale = (button.tag) ? 1.2 : 0.8;
    
    self.iconButton.transform = CGAffineTransformScale(self.iconButton.transform, scale, scale);
    
    NSLog(@"%@", NSStringFromCGAffineTransform(self.iconButton.transform));
    
//    // 用frame来调整按钮大小
//    // 1. 取出bounds
//    CGRect frame = self.iconButton.bounds;
//    
//    // 判断点了那个按钮
//    if (button.tag) {
//        NSLog(@"放大");
//        frame.size.width += 50;
//        frame.size.height += 50;
//    } else {
//        NSLog(@"缩小");
//        frame.size.width -= 50;
//        frame.size.height -= 50;
//    }
//    
//    /**
//     收尾式动画
//     // 1> 准备开始一个动画
//     [UIView beginAnimations:nil context:nil];
//     
//     // 2> 修改控件属性的代码，就可以实现动画
//     
//     // 3> 提交动画
//     [UIView commitAnimations];
//     
//     补充
//     可以使用
//     [UIView setAnimationDuration:1.0];
//     设置动画执行的时长
//     */
//    // 1> 准备开始一个动画
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:1.0];
//    
//    // 重新设置bounds
//    self.iconButton.bounds = frame;
//    
//    // 3> 提交动画
//    [UIView commitAnimations];
}

// 通过frame调整大小
- (void)zoomWithFrame:(UIButton *)button
{
    // 用frame来调整按钮大小
    // 1. 取出frame
    CGRect frame = self.iconButton.frame;
    
    // 判断点了那个按钮
    if (button.tag) {
        NSLog(@"放大");
        frame.size.width += 20;
        frame.size.height += 20;
    } else {
        NSLog(@"缩小");
        frame.size.width -= 20;
        frame.size.height -= 20;
    }
    
    // 重新设置frame
    self.iconButton.frame = frame;
}

/** 旋转 */
- (IBAction)rotate:(UIButton *)button
{
    // 在OC的开发中，关于角度统一都使用弧度值，逆时针是负值，顺时针是正值
    // 180° = M_PI
    CGFloat angle = (button.tag) ? -M_PI_4 : M_PI_4;
    
    [UIView beginAnimations:nil context:nil];
    self.iconButton.transform = CGAffineTransformRotate(self.iconButton.transform, angle);
    [UIView commitAnimations];

    NSLog(@"%@", NSStringFromCGAffineTransform(self.iconButton.transform));
    NSLog(@"%@", NSStringFromCGRect(self.iconButton.frame));
}

@end
