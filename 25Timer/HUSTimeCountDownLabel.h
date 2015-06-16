//
//  HUSTimerCountDownLabel.h
//  25Timer
//
//  Created by HuS on 15/6/13.
//  Copyright © 2015年 HuS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HUSTimeCountDownLabel;//前置声明
//声明委托协议
@protocol HUSTimeCountDownLabelDelegate <NSObject>
@optional
- (void)timerLabel:(HUSTimeCountDownLabel *)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime;
- (void)keepGoing:(NSTimeInterval) timeLeft;
@end



@interface HUSTimeCountDownLabel : UILabel

@property (nonatomic, copy) NSString *timeFormat;
@property (strong, nonatomic) UILabel *timeLabel;
//计时器是否在倒计时
@property (nonatomic, readonly) BOOL counting;
@property (nonatomic, weak) id <HUSTimeCountDownLabelDelegate> delegate;


/*指定初始化方法*/
- (instancetype)initWithFrame:(CGRect)frame label:(UILabel *)label;
/*初始化方法*/
- (instancetype)initWithLabel:(UILabel *)label;

/*Setter Methods*/
- (void)setCountDownTime:(NSTimeInterval)time;

/*Getter Methods*/


/* Timer Controller methods */
- (void)start;
- (void)pause;
- (void)reset;

/*Animation Method*/
- (void)beginLabelAnimation;
@end
