//
//  MeditationViewController.m
//  25Timer
//
//  Created by HuS on 15/6/15.
//  Copyright © 2015年 HuS. All rights reserved.
//

#import "MeditationViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "SettingViewController.h"

@interface MeditationViewController () <AVAudioPlayerDelegate, SettingViewPassValueDelegate>//接受协议
{
    BOOL playing;
}
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (nonatomic) AVAudioPlayer *rainPlayer;
@property (nonatomic) AVAudioPlayer *firePlayer;
@property (nonatomic) AVAudioPlayer *riverPlayer;
@property (nonatomic) AVAudioPlayer *seaPlayer;
@property (nonatomic) AVAudioPlayer *forestPlayer;

@end

@implementation MeditationViewController


#pragma mark - View Circle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNoiseMode];
    [self initPlayers];
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 用户交互事件
- (IBAction)play:(id)sender
{
    if (!playing) {
        [self.rainPlayer play];
        [self.firePlayer play];
        [self.playButton setBackgroundImage:[UIImage imageNamed:@"Pause"] forState:UIControlStateNormal];
        playing = !playing;
    } else {
        [self.rainPlayer pause];
        [self.firePlayer pause];
        [self.playButton setBackgroundImage:[UIImage imageNamed:@"Play"] forState:UIControlStateNormal];
        playing = !playing;
    }
    
 
    
}

#pragma mark - Delegate Methods
- (void)passSettingValue:(NSMutableArray *)noiseSwitch noiseVolume:(NSMutableArray *)noiseVolume
{
    self.noiseSwitch = noiseSwitch;
    self.noiseVolumeValue = noiseVolume;
    NSLog(@"did i ?");
}

#pragma mark - Segue Methods
- (IBAction)returnToMediationView:(UIStoryboardSegue *)segue
{
}
    
#pragma mark - Private Methods
- (void)initNoiseMode
{
    self.noiseVolumeValue = [[NSMutableArray alloc] init];
    for (int i=0; i<5; i++) {
        [self.noiseVolumeValue addObject:[NSNumber numberWithFloat:0.5]];
    }
}

- (NSArray *)loadSounds
{
    NSString *rainSoundFilePath = [[NSBundle mainBundle] pathForResource:@"rain" ofType:@"mp3"];
    NSString *fireSoundFilePath = [[NSBundle mainBundle] pathForResource:@"fire" ofType:@"mp3"];
    NSString *riverSoundFilePath = [[NSBundle mainBundle] pathForResource:@"river" ofType:@"mp3"];
    NSString *seaSoundFilePath = [[NSBundle mainBundle] pathForResource:@"sea" ofType:@"mp3"];
    NSString *forestSoundFilePath = [[NSBundle mainBundle] pathForResource:@"forest" ofType:@"mp3"];
    NSArray *allSoundsPath = @[rainSoundFilePath, fireSoundFilePath,riverSoundFilePath,seaSoundFilePath,forestSoundFilePath];
    return allSoundsPath;
}

- (void)initPlayers
{
    //加载音乐文件
    NSArray *soundsPath = [self loadSounds];
    //转换成URL
    NSMutableArray *soundsURL = [[NSMutableArray alloc] init];
    for (int i=0; i<5; i++) {
        NSURL *url = [NSURL fileURLWithPath:soundsPath[i]];
        [soundsURL addObject: url];
    }
    NSLog(@"%@", soundsURL);
    
    //初始化播放器
    
    NSError *error = nil;
    self.rainPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundsURL[0] error:&error];
    self.firePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundsURL[1] error:&error];
    self.riverPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundsURL[2] error:&error];
    self.seaPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundsURL[3] error:&error];
    self.forestPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundsURL[4] error:&error];
    
    self.rainPlayer.delegate = self;
    self.rainPlayer.numberOfLoops = -1;
    self.rainPlayer.volume = [self.noiseVolumeValue[0] floatValue];
    [self.rainPlayer prepareToPlay];
    
    self.firePlayer.delegate = self;
    self.firePlayer.numberOfLoops = -1;
    self.firePlayer.volume = [self.noiseVolumeValue[1] floatValue];
    [self.firePlayer prepareToPlay];
    
    self.riverPlayer.delegate = self;
    self.riverPlayer.numberOfLoops = -1;
    self.riverPlayer.volume = [self.noiseVolumeValue[2] floatValue];
    [self.riverPlayer prepareToPlay];
    
    self.seaPlayer.delegate = self;
    self.seaPlayer.numberOfLoops = -1;
    self.seaPlayer.volume = [self.noiseVolumeValue[3] floatValue];
    [self.seaPlayer prepareToPlay];
    
    self.forestPlayer.delegate = self;
    self.forestPlayer.numberOfLoops = -1;
    self.forestPlayer.volume = [self.noiseVolumeValue[4] floatValue];
    [self.forestPlayer prepareToPlay];
    playing = NO;
    
}
@end
