//
//  HUSTimeCountDownLabel.m
//  25Timer
//
//  Created by HuS on 15/6/13.
//  Copyright © 2015年 HuS. All rights reserved.
//

#import "HUSTimeCountDownLabel.h"

#define kDefaultTimeFormat  @"mm:ss"
#define kDefaultFireIntervalNormal  0.1

@interface HUSTimeCountDownLabel()
{
    NSTimeInterval countTime;//设置的倒计时秒数
    NSDate *date1970;
    NSDate *timeToCountOff;//与date1970的倒计时差
    NSDate *startCountDate;//开始计时的时间
    NSDate *pausedTime;//暂停时的时间
}

@property (strong, nonatomic)NSTimer *timer;
@property (strong, nonatomic)NSDateFormatter *dateFormatter;

@end
@implementation HUSTimeCountDownLabel

#pragma mark - Initialize method
//初始化方法
- (instancetype)initWithLabel:(UILabel *)label
{
    return [self initWithFrame:CGRectZero label:label];
}
//指定初始化方法
- (instancetype)initWithFrame:(CGRect)frame label:(UILabel *)label
{
    self = [super initWithFrame:frame];
    if (self) {
        self.timeLabel = label;
        [self setup];
    }
    return self;
}

#pragma mark - Getter and Setter Methods
//设置倒计时时间
- (void)setCountDownTime:(NSTimeInterval)time
{
    countTime = (time < 0 )? 0 : time;
    timeToCountOff = [date1970 dateByAddingTimeInterval:countTime];//date1970+countTime
    [self updateLabel];
}

//设置时间显示格式
- (NSDateFormatter*)dateFormatter{
    
    if (_dateFormatter == nil) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
        [_dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
        _dateFormatter.dateFormat = kDefaultTimeFormat;
    }
    return _dateFormatter;
}

- (UILabel *)timeLabel
{
    if (_timeLabel == nil) {
        _timeLabel = self;
    }
    return _timeLabel;
}


#pragma mark - Timer Controller Methods
- (void)start
{
    if (_timer) {
        //remove a timer from an NSRunLoop object
        [_timer invalidate];
        _timer = nil;
    }
    //Creates and returns a new NSTimer object and schedules it on the current run loop in the default mode.
    _timer = [NSTimer scheduledTimerWithTimeInterval:kDefaultFireIntervalNormal target:self selector:@selector(updateLabel) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
    if (startCountDate == nil) {
        startCountDate = [NSDate date];
    }

    if(pausedTime != nil){
        NSTimeInterval countedTime = [pausedTime timeIntervalSinceDate:startCountDate];
        startCountDate = [[NSDate date] dateByAddingTimeInterval:-countedTime];
        pausedTime = nil;
    }
    _counting = YES;//设置正在计时
    [_timer fire];
}

- (void)pause
{
    if (_counting) {
        pausedTime = [NSDate date];//记录暂停时的时间
        [_timer invalidate];
        _timer = nil;
        _counting = NO;
    }
}

- (void)reset
{
    pausedTime = nil;
    startCountDate = nil;
    [_timer invalidate];
    _timer = nil;
    _counting = NO;
    [self updateLabel];
}

#pragma mark - Private method
- (void)setup
{
    date1970 = [NSDate dateWithTimeIntervalSince1970:0];
    [self updateLabel];
}

- (void)updateLabel
{
    //开始计时时间与当前时间的时间差
    NSTimeInterval timeDiff = [[NSDate date] timeIntervalSinceDate:startCountDate];
    NSDate *timeToShow = [NSDate date];
    BOOL isTimeEnd = NO;
    
    if (_counting) {
        if (timeDiff >= countTime) {
            startCountDate = nil;
            [self pause];
            timeToShow = [date1970 dateByAddingTimeInterval:0];
            pausedTime = nil;
            isTimeEnd = YES;
        } else {
            timeToShow = [timeToCountOff dateByAddingTimeInterval:timeDiff * -1];
        }
    } else {
        timeToShow = timeToCountOff;
    }
    
    self.timeLabel.text = [self.dateFormatter stringFromDate:timeToShow];
    
    if (isTimeEnd) {
        if([_delegate respondsToSelector:@selector(timerLabel:finshedCountDownTimerWithTime:)]){
            [_delegate timerLabel:self finshedCountDownTimerWithTime:countTime];
        }
    }
    //test
    NSTimeInterval timeLeft = [timeToShow timeIntervalSinceDate:date1970];
    [_delegate keepGoing:timeLeft];
    
}

#pragma mark - Animation Method
//- (void)beginLabelAnimation
//{
//    NSTimer *animationTimer = [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(updateBeginLabel) userInfo:nil repeats:YES];
//}
//- (void)updateBeginLabel
//{
//    int i = 0;
//    self.timeLabel.text = @(i);
//    i++;
//}
@end
