//
//  HomeViewController.m
//  Newspaper_3
//
//  Created by Mac on 1/22/18.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "HomeViewController.h"
#import "NewsViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBarHidden = YES;

    [self.navigationController setToolbarHidden:NO];
    self.navigationController.toolbar.tintColor = UIColor.lightGrayColor;
    
    [self moveToNewsView];
}

- (void)moveToNewsView
{
    NewsViewController *newsView = [[NewsViewController alloc]init];
    newsView.urlString = RSS_NEWS;
    newsView.newsFlag = YES;
    [self.navigationController pushViewController:newsView animated:YES];
}

@end
