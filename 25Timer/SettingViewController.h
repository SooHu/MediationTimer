//
//  SettingViewController.h
//  25Timer
//
//  Created by HuS on 15/6/16.
//  Copyright © 2015年 HuS. All rights reserved.
//

#import <UIKit/UIKit.h>
//声明协议
@protocol SettingViewPassValueDelegate <NSObject>
- (void)passSettingValue:(NSMutableArray *)noiseSwitch noiseVolume:(NSMutableArray *)noiseVolume;

@end

@interface SettingViewController : UITableViewController
@property (nonatomic) NSArray *noiseMixMode;

@property (nonatomic) NSMutableArray *nosieSwitch;
@property (nonatomic) NSMutableArray *nosieVolumeValue;

@property (nonatomic) id<SettingViewPassValueDelegate> delegate;
@end
