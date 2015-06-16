//
//  SetTableViewController.m
//  25Timer
//
//  Created by HuS on 15/6/15.
//  Copyright © 2015年 HuS. All rights reserved.
//

#import "SetTableViewController.h"

@interface SetTableViewController ()

@end

@implementation SetTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置状态栏样式
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationController.title = @"设置";
    [self.navigationController.navigationBar setBarTintColor:[UIColor grayColor]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor grayColor]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(nonnull UITableView *)tableView didDeselectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSLog(@"%d",indexPath.row);
}


@end
