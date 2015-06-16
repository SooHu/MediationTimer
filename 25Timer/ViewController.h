//
//  ViewController.h
//  25Timer
//
//  Created by HuS on 15/6/13.
//  Copyright © 2015年 HuS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HUSTimeCountDownLabel.h"
#import "CircleProgressView.h"

@interface ViewController : UIViewController
{
    HUSTimeCountDownLabel *timerLabel;
}
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
//circleProgressView
@property (weak, nonatomic) IBOutlet CircleProgressView *circleProgressView;
//背景图片
@property (weak, nonatomic) IBOutlet UIImageView *backgoundImageView;
@end

