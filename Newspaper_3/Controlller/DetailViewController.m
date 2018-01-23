//
//  DetailViewController.m
//  Newspaper_3
//
//  Created by Mac on 1/21/18.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "DetailViewController.h"
#import "NewsViewController.h"
#import "BarView.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

//MARK: Configure toolbar
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self setUpView];

    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    flexible.width = 38;

    BarView *barNews = [[BarView alloc]init];
    [barNews setTitle:@"News" andImage:[UIImage imageNamed:@"news-icon.png"] andTitleColor:self.newsFlag];
    UITapGestureRecognizer *tapNews = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moveToNewsView)];
    [barNews addGestureRecognizer:tapNews];
    UIBarButtonItem *barNewsBtn = [[UIBarButtonItem alloc]initWithCustomView:barNews];

    BarView *barTravel = [[BarView alloc]init];
    [barTravel setTitle:@"Travel" andImage:[UIImage imageNamed:@"travel-icon.png"] andTitleColor:self.travelFlag];
    UITapGestureRecognizer *tapTravel = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moveToTravelView)];
    [barTravel addGestureRecognizer:tapTravel];
    UIBarButtonItem *barTravelBtn = [[UIBarButtonItem alloc]initWithCustomView:barTravel];

    BarView *barSport = [[BarView alloc]init];
    [barSport setTitle:@"Sport" andImage:[UIImage imageNamed:@"sport-icon.png"] andTitleColor:self.sportFlag];
    UITapGestureRecognizer *tapSport = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moveToSportView)];
    [barSport addGestureRecognizer:tapSport];
    UIBarButtonItem *barSportBtn = [[UIBarButtonItem alloc]initWithCustomView:barSport];

    BarView *barEntertain = [[BarView alloc]init];
    [barEntertain setTitle:@"Entertainment" andImage:[UIImage imageNamed:@"entertainment-icon.png"] andTitleColor:self.entertainFlag];
    UITapGestureRecognizer *tapEntertain = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moveToEntertainView)];
    [barEntertain addGestureRecognizer:tapEntertain];
    UIBarButtonItem *barEntertainBtn = [[UIBarButtonItem alloc]initWithCustomView:barEntertain];

    [self setToolbarItems:@[flexible, barNewsBtn, flexible, barTravelBtn, flexible, barSportBtn, flexible, barEntertainBtn] animated:YES];
}

- (void)moveToNewsView
{
    NewsViewController *newsView = [[NewsViewController alloc]init];
    newsView.urlString = RSS_NEWS;
    newsView.newsFlag = YES;
    newsView.travelFlag = NO;
    newsView.sportFlag = NO;
    newsView.entertainFlag = NO;
    [self.navigationController pushViewController:newsView animated:YES];

}

-(void)moveToTravelView
{
    NewsViewController *newsView = [[NewsViewController alloc]init];
    newsView.urlString = RSS_TRAVEL;
    newsView.newsFlag = NO;
    newsView.travelFlag = YES;
    newsView.sportFlag = NO;
    newsView.entertainFlag = NO;
    [self.navigationController pushViewController:newsView animated:YES];
}

-(void)moveToSportView
{
    NewsViewController *newsView = [[NewsViewController alloc]init];
    newsView.urlString = RSS_SPORT;
    newsView.newsFlag = NO;
    newsView.travelFlag = NO;
    newsView.sportFlag = YES;
    newsView.entertainFlag = NO;
    [self.navigationController pushViewController:newsView animated:YES];

}

-(void)moveToEntertainView
{
    NewsViewController *newsView = [[NewsViewController alloc]init];
    newsView.urlString = RSS_ENTERTAINMENT;
    newsView.newsFlag = NO;
    newsView.travelFlag = NO;
    newsView.sportFlag = NO;
    newsView.entertainFlag = YES;
    [self.navigationController pushViewController:newsView animated:YES];
}

// Configure WebView
-(void)setUpView
{
    HeaderView *headerView = [[HeaderView alloc]init];
    [headerView setHeaderWithController:self ];
    [self.view addSubview:headerView];

    [self.myWebView setFrame:CGRectMake(0, headerView.bounds.size.height, SCREEN_WIDTH, SCREEN_HEIGHT-headerView.bounds.size.height)];

    [self loadWebContents];
}

-(void)loadWebContents
{
    self.myWebView.scrollView.bounces=NO;

    NSURL *url = [NSURL URLWithString:self.itemModel.link];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    self.myWebView.delegate = self;
    [self.myWebView loadRequest:request];
}

//MARK: UIWebViewDelegate
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    // remove the advertisement of VNExpress newspaper
    NSString *jsString = @"document.getElementById('header').style.display='none'; document.getElementsByClassName('cat_header')[0].style.display='none'; document.getElementsByClassName('myvne_user')[0].style.display='none';  document.getElementById('wrapper_footer').style.display='none'; document.getElementById('box_morelink_detail').style.display='none';   document.getElementsByClassName('block_tag')[0].style.display='none'; document.getElementsByClassName('block_tag width_common')[0].style.display='none'; document.getElementsByClassName('box_bottom_detail')[0].style.display='none'; document.getElementsByClassName('box_tin_khac')[0].style.display='none'; document.getElementsByClassName('box_tintaitro')[0].style.display='none'; document.getElementsByClassName('bottom_detail')[0].style.display='none';";
    [self.myWebView stringByEvaluatingJavaScriptFromString:jsString];

    [self.loader startAnimating];
    [self.loader setHidden:NO];
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:YES];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.loader stopAnimating];
    [self.loader setHidden:YES];
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:NO];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.loader stopAnimating];
    [self.loader setHidden:YES];
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:NO];
}

@end
