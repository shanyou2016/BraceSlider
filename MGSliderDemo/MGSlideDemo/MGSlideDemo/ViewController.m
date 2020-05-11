//
//  ViewController.m
//  MGSlideDemo
//
//  Created by maling on 2019/7/24.
//  Copyright © 2019 maling. All rights reserved.
//

#import "ViewController.h"
#import "MGSlider.h"
@interface ViewController (){
    UILabel *label;
    float proportion;//拖动条显示的最大值
    
     float lattice;//一格的值===》1 / 100  === X/ proportion==》 x==0.01 * proportion
    
    MGSlider *slider;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    proportion = 10.0;
    lattice = 0.01 * proportion;
    
    slider = [[MGSlider alloc] initWithFrame:CGRectMake(20, 200, [UIScreen mainScreen].bounds.size.width - 40, 50)];
    slider.thumbSize = CGSizeMake(50, 50);//锚点的大小
    slider.thumbImage = [UIImage imageNamed:@"icon_activity_ticket_details_rebate"];//锚点的图片
    slider.thumbColor = [UIColor clearColor];//锚点的背景色
    slider.trackColor = [UIColor colorWithRed:0.29 green:0.42 blue:0.86 alpha:1.00];//进度条的颜色+
    slider.untrackColor = [UIColor greenColor];//进度条的颜色-
    slider.zoom = NO; // 默认点击放大
    slider.progress = 0;// 默认第一次锚点所在的位置，1：100%
    slider.margin = 70; // 距离左右内间距
    [self.view addSubview:slider];
    [slider changeValue:^(CGFloat value) {
        NSLog(@">>>>>>>>>>>>>>>>>>>>>拖动==== %f", value);
        
        NSString *x =[NSString stringWithFormat:@"%.2f%@",self->lattice * value*100,@"%"];
        [self->label setText:x];
        
    } endValue:^(CGFloat value) {
        NSLog(@"end====: %f", value);
    }];
    
//    UIImageView *reductionImgV  = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_activity_ticket_details_minus"]];
    UIButton *reductionImgV = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [reductionImgV setBackgroundImage:[UIImage imageNamed:@"icon_activity_ticket_details_minus"] forState:(UIControlStateNormal)];
    reductionImgV.frame = CGRectMake(20, 200, 50, 50);
    [self.view addSubview:reductionImgV];
    [reductionImgV addTarget:self  action:@selector(reductionAction:) forControlEvents:(UIControlEventTouchDown)];
    
    
    
//    UIImageView *addImgV  = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_activity_ticket_details_add"]];
    UIButton *addImgV = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [addImgV setBackgroundImage:[UIImage imageNamed:@"icon_activity_ticket_details_add"] forState:(UIControlStateNormal)];
    addImgV.frame = CGRectMake(350, 200, 50, 50);
    [self.view addSubview:addImgV];
    [addImgV addTarget:self  action:@selector(addImgVAction:) forControlEvents:(UIControlEventTouchDown)];
    
    
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(150, 250, 200, 50)];
    label.text = @"显示0.0%";
    [self.view addSubview:label];
    
    MGSlider *slider2 = [[MGSlider alloc] initWithFrame:CGRectMake(20, 380, [UIScreen mainScreen].bounds.size.width - 40, 50)];
    slider2.progressLineHeight = 15;
    slider2.thumbSize = CGSizeMake(30, 30);
    slider2.zoom = NO;
    slider2.thumbImage = [UIImage imageNamed:@"icon_feature_oval"];
    slider2.trackImage = [UIImage imageNamed:@"food"];
    slider2.trackColor = [UIColor colorWithRed:0.29 green:0.42 blue:0.86 alpha:1.00];
    slider2.untrackImage = [UIImage imageNamed:@"food1"];
    [self.view addSubview:slider2];
    
}



-(void)reductionAction:(UIButton *)sender{
    NSLog(@"移动的progress = %f",slider.moveProgress);

    NSLog(@"结束的progress = %f",slider.endProgress);

    NSLog(@"当前的progress = %f",slider.progress);
    
    if (slider.moveProgress> 0) {
        
        slider.moveProgress = slider.moveProgress - 0.001;
        slider.progress = slider.moveProgress;
        NSLog(@"slider.progress = %f ",slider.progress);
        
        NSString *x =[NSString stringWithFormat:@"%.2f%@",self->lattice * slider.progress*100,@"%"];
        NSLog(@"当前的 = %@",x);
        [self->label setText:x];
        
        

    }

}

-(void)addImgVAction:(UIButton *)sender{
    NSLog(@"移动的progress = %f",slider.moveProgress);

    if (slider.moveProgress< 1.0) {
        slider.moveProgress = slider.moveProgress + 0.001;
        slider.progress = slider.moveProgress;
        NSLog(@"slider.progress = %f ",slider.progress);
        NSString *x =[NSString stringWithFormat:@"%.2f%@",self->lattice * slider.progress*100 ,@"%"];
        NSLog(@"当前的 = %@",x);
        [self->label setText:x];
    }

}

//实际开发发现相关的知识点
//        if (self.slider.progress >0.8) {
//            //该控件的bug  该控件用个bug 就是点+ - 按钮，第一下会往前跳动一下，实际开发中用这段代码强行求正
//            CGRect frame =  self.slider.valveIV.frame;
//            if (frame.origin.x >= 90.0) {
//                frame.origin.x = 90.0;
//                self.slider.valveIV.frame = frame;
//            }
//            NSLog(@"x= %f",frame.origin.x);
//        }

//实际中计算赔率用到的知识
//小数向上取整，指小数部分直接进1：
//
// x = 2.222，ceilf(x) = 3。
//
//小数向下取整，指直接去掉小数部分：
//
// x = 2.222，floor(x) = 2。
//
//小数四舍五入，指>0.5向上加1 ，小于0.5去掉小数部分 ：
//
//x = 2.222，round(x) = 2;
//
//y = 2.555，round(y) = 3。
@end
