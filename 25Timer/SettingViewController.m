//
//  SettingViewController.m
//  25Timer
//
//  Created by HuS on 15/6/16.
//  Copyright © 2015年 HuS. All rights reserved.
//

#import "SettingViewController.h"
#import "MeditationViewController.h"
@interface SettingViewController () <SettingViewPassValueDelegate>//接受协议
@property (weak, nonatomic) IBOutlet UIImageView *rainImageView;
@property (weak, nonatomic) IBOutlet UIImageView *fireImageView;
@property (weak, nonatomic) IBOutlet UIImageView *riverImageView;
@property (weak, nonatomic) IBOutlet UIImageView *seaImageView;
@property (weak, nonatomic) IBOutlet UIImageView *forestImageView;

@property (weak, nonatomic) IBOutlet UISlider *rainSlider;
@property (weak, nonatomic) IBOutlet UISlider *fireSlider;
@property (weak, nonatomic) IBOutlet UISlider *riverSlider;
@property (weak, nonatomic) IBOutlet UISlider *seaSlider;
@property (weak, nonatomic) IBOutlet UISlider *forestSlider;



@end

@implementation SettingViewController


#pragma mark - Setter and Getter Methods






#pragma mark - View Circle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置初始NoisSwitch
    self.nosieSwitch = [[NSMutableArray alloc] initWithArray:@[@"NO",@"NO",@"NO",@"NO",@"NO"]];
    self.nosieVolumeValue = [[NSMutableArray alloc] initWithArray:@[@0.0,@0.0,@0.0,@0.0,@0.0]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:(BOOL)animated];
    //监测音量设置条变化
    self.nosieVolumeValue[0] = [NSNumber numberWithFloat:self.rainSlider.value];
    self.nosieVolumeValue[1] = [NSNumber numberWithFloat:self.fireSlider.value];
    self.nosieVolumeValue[2] = [NSNumber numberWithFloat:self.riverSlider.value];
    self.nosieVolumeValue[3] = [NSNumber numberWithFloat:self.seaSlider.value];
    self.nosieVolumeValue[4] = [NSNumber numberWithFloat:self.forestSlider.value];
    NSLog(@"viewdidappear");
    
    [_delegate passSettingValue:self.nosieSwitch noiseVolume:self.nosieVolumeValue];
}

#pragma mark - TableView delegate Methods
- (void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
        case 0:
            if ([self.nosieSwitch[0] isEqualToString:@"NO"]) {
                self.nosieSwitch[0] = @"YES";
                self.rainImageView.image = [UIImage imageNamed:@"rain-icon-disabled"];
            } else {
                self.nosieSwitch[0] = @"NO";
                self.rainImageView.image = [UIImage imageNamed:@"rain-icon"];
            }
            break;
       case 1:
            if ([self.nosieSwitch[1] isEqualToString:@"NO"]) {
                self.nosieSwitch[1] = @"YES";
                self.fireImageView.image = [UIImage imageNamed:@"fire-icon-disabled"];
            } else {
                self.nosieSwitch[1] = @"NO";
                self.fireImageView.image = [UIImage imageNamed:@"fire-icon"];
            }
            break;
        case 2:
            if ([self.nosieSwitch[2] isEqualToString:@"NO"]) {
                self.nosieSwitch[2] = @"YES";
                self.riverImageView.image = [UIImage imageNamed:@"river-icon-disabled"];
            } else {
                self.nosieSwitch[2] = @"NO";
                self.riverImageView.image = [UIImage imageNamed:@"river-icon"];
            }
            break;
        case 3:
            if ([self.nosieSwitch[3] isEqualToString:@"NO"]) {
                self.nosieSwitch[3] = @"YES";
                self.seaImageView.image = [UIImage imageNamed:@"water-icon-disabled"];
            } else {
                self.nosieSwitch[3] = @"NO";
                self.seaImageView.image = [UIImage imageNamed:@"water-icon"];
            }
            break;
        case 4:
            if ([self.nosieSwitch[4] isEqualToString:@"NO"]) {
                self.nosieSwitch[4] = @"YES";
                self.forestImageView.image = [UIImage imageNamed:@"forest-icon-disabled"];
            } else {
                self.nosieSwitch[4] = @"NO";
                self.forestImageView.image = [UIImage imageNamed:@"forest-icon"];
            }
            break;
        default:
            break;
    }
}

#pragma mark - Private Method
- (void)sliderValueChanged:(NSString *)name
{

}




@end
