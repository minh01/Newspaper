//
//  NewsViewController.m
//  Newspaper_3
//
//  Created by Mac on 1/21/18.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "NewsViewController.h"
#import "BarView.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
}

//MARK: Configure toolbar
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    self.navigationItem.hidesBackButton = YES;

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
    if (self.newsFlag)
    {
        return;
    } else {
        NewsViewController *newsView = [[NewsViewController alloc]init];
        newsView.urlString = RSS_NEWS;
        newsView.newsFlag = YES;
        newsView.travelFlag = NO;
        newsView.sportFlag = NO;
        newsView.entertainFlag = NO;
        [self.navigationController pushViewController:newsView animated:YES];
    }
}

-(void)moveToTravelView
{
    if (self.travelFlag) {
        return;
    } else {
        NewsViewController *newsView = [[NewsViewController alloc]init];
        newsView.urlString = RSS_TRAVEL;
        newsView.newsFlag = NO;
        newsView.travelFlag = YES;
        newsView.sportFlag = NO;
        newsView.entertainFlag = NO;
        [self.navigationController pushViewController:newsView animated:YES];
    }
}

-(void)moveToSportView
{
    if (self.sportFlag) {
        return;
    } else {
        NewsViewController *newsView = [[NewsViewController alloc]init];
        newsView.urlString = RSS_SPORT;
        newsView.newsFlag = NO;
        newsView.travelFlag = NO;
        newsView.sportFlag = YES;
        newsView.entertainFlag = NO;
        [self.navigationController pushViewController:newsView animated:YES];
    }
}

-(void)moveToEntertainView
{
    if (self.entertainFlag) {
        return;
    } else {
        NewsViewController *newsView = [[NewsViewController alloc]init];
        newsView.urlString = RSS_ENTERTAINMENT;
        newsView.newsFlag = NO;
        newsView.travelFlag = NO;
        newsView.sportFlag = NO;
        newsView.entertainFlag = YES;
        [self.navigationController pushViewController:newsView animated:YES];
    }
}

//MARK: Configure table
-(void)setUpView
{
    [self.myTable setFrame:CGRectMake(0, STATUS_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT -STATUS_HEIGHT)];

    self.myTable.rowHeight = UITableViewAutomaticDimension;
   
    [self.myTable setSeparatorColor:[UIColor blueColor]];

    self.myTable.delegate = self;
    self.myTable.dataSource = self;

    [self.myTable registerNib:[UINib nibWithNibName:@"CellView" bundle:nil] forCellReuseIdentifier:@"CELL"];
    [self getData];
}

-(void)getData
{
    [MANAGER getRssFeedsWithUrlString:self.urlString completion:^(BOOL success, NSArray *feeds, NSString *errorMessage) {
        if (success == YES) {
            dataList = [NSMutableArray arrayWithArray:feeds];
            [self.myTable reloadData];
        };
    }];
}

//MARK: UITableViewDataSoure and UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellView *cell = [self.myTable dequeueReusableCellWithIdentifier:@"CELL"];
    cell.delegate = self;
    [cell setCellWithItem:[dataList objectAtIndex:[indexPath row]]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self moveToDetailView:[dataList objectAtIndex:indexPath.row]];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
}

//MARK: CellViewDelegate
-(void)moveToDetailView:(ItemModel *)currentItem
{
    DetailViewController *detail = [[DetailViewController alloc]init];
    [detail.view setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    detail.itemModel = currentItem;
    detail.newsFlag = self.newsFlag;
    detail.travelFlag = self.travelFlag;
    detail.sportFlag = self.sportFlag;
    detail.entertainFlag = self.entertainFlag;
    [self.navigationController pushViewController:detail animated:YES];
}

@end
