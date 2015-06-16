//
//  ViewController.m
//  25Timer
//
//  Created by HuS on 15/6/13.
//  Copyright © 2015年 HuS. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController () <HUSTimeCountDownLabelDelegate>//接受协议
{
    BOOL viewFirstLoad;
    SystemSoundID soundID;
}
- (void)handleSingleTapGesture:(UITapGestureRecognizer *)tapGestureRecognizer;
- (void)handleSingleTapOnButtonGesture:(UITapGestureRecognizer *)tapGestureRecognizer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    viewFirstLoad = YES;
    
    //设置磨玻璃效果
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.frame = self.backgoundImageView.bounds;
    [self.backgoundImageView addSubview:blurEffectView];
    
    //设置背景颜色NSColor(red:0.26, green:0.28, blue:0.33, alpha:1)
    self.view.backgroundColor = [UIColor colorWithRed:0.26 green:0.28 blue:0.33 alpha:1.0];
    
    //初始化一个倒计时label
    timerLabel = [[HUSTimeCountDownLabel alloc] initWithLabel:self.label];
    //设置倒计时时间
    [timerLabel setCountDownTime:60];
    timerLabel.delegate = self;
    
    
    //设置circleProgressView
    self.circleProgressView.timeLimit = 60;
    self.circleProgressView.elapsedTime = 0;
    
    
    self.label.text = @"开始";
    
    //设置动画初始状态
    self.circleProgressView.transform = CGAffineTransformMakeScale(0, 0);

    //初始化手势操作
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTapGesture:)];
    UITapGestureRecognizer *singleTapOnButtonGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resetCountDown:)];
    [self.circleProgressView addGestureRecognizer:singleTapGestureRecognizer];
    [self.resetButton addGestureRecognizer:singleTapOnButtonGestureRecognizer];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //动画效果
    [UIView animateWithDuration:1 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
        self.circleProgressView.transform = CGAffineTransformMakeScale(1.5, 1.5);
        self.circleProgressView.transform = CGAffineTransformMakeScale(1, 1);
    } completion:nil];
    

    //test
    if (viewFirstLoad) {
        [self.circleProgressView.progressLayer beginAnimation];
//        [timerLabel beginLabelAnimation];
        viewFirstLoad = NO;
    }
}

#pragma mark - Button Methods
- (IBAction)startOrPauseCountDown:(id)sender
{
    if([timerLabel counting]){
        [timerLabel pause];
        [self.startButton setTitle:@"继续" forState:UIControlStateNormal];
    }else{
        [timerLabel start];
        [self.startButton setTitle:@"暂停" forState:UIControlStateNormal];
    }
}


- (IBAction)resetCountDown:(id)sender
{
    
    [timerLabel reset];
    [self.startButton setTitle:@"开始" forState:UIControlStateNormal];
    //播放音效
    [self playSoundEffect:@"pop" type:@"wav"];
    self.label.text = @"开始";
}

#pragma mark - Delegate Methods
//实现委托方法
- (void)timerLabel:(HUSTimeCountDownLabel *)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime{
    
    NSString *msg = [NSString stringWithFormat:@"Countdown of Example 6 finished!\nTime counted: %i seconds",(int)countTime];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:msg delegate:nil cancelButtonTitle:@"Awesome!" otherButtonTitles:nil];
    [alertView show];
    
    [self.startButton setTitle:@"开始" forState:UIControlStateNormal];
    self.label.text = @"你已成功完成了一个番茄时间！";
}
//委托方法test
- (void)keepGoing:(NSTimeInterval)timeLeft
{
    self.circleProgressView.elapsedTime = timeLeft;
    NSLog(@"keep goning %f", timeLeft);
}

#pragma mark - GestureRecognizer Handle Methods
- (void)handleSingleTapGesture:(UITapGestureRecognizer *)tapGestureRecognizer
{
    //播放音效
    [self playSoundEffect:@"pop" type:@"wav"];
    if([timerLabel counting]){
        [timerLabel pause];
        [self.startButton setTitle:@"继续" forState:UIControlStateNormal];
    }else{
        [timerLabel start];
        [self.startButton setTitle:@"暂停" forState:UIControlStateNormal];
    }
    
    //动画效果
    [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
        self.circleProgressView.transform = CGAffineTransformMakeScale(1.5, 1.5);
        self.circleProgressView.transform = CGAffineTransformMakeScale(1, 1);
    } completion:nil];
    //动画效果
//    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
//        self.circleProgressView.transform = CGAffineTransformMakeScale(1, 1);
//    } completion:nil];
}


#pragma mark - Play Music or Audio
-(void)playSoundEffect:(NSString *)name type:(NSString *)type
{
    NSString *soundFilePath =[[NSBundle mainBundle] pathForResource:name ofType:type];
    NSURL *soundURL = [NSURL fileURLWithPath:soundFilePath];
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL, &soundID);
    AudioServicesPlaySystemSound(soundID);//播放系统音效
}

#pragma mark - Segue Method
- (IBAction)closeMeditationView:(UIStoryboardSegue *)segue
{
}
@end
