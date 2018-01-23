//
//  NewsViewController.h
//  Newspaper_3
//
//  Created by Mac on 1/21/18.
//  Copyright © 2018 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellView.h"
#import "HeaderView.h"
#import "DetailViewController.h"

@interface NewsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, CellViewDelegate>
{
    NSMutableArray *dataList;
}

@property(nonatomic,weak) IBOutlet UITableView *myTable;
@property(nonatomic) NSString *urlString;

// a flag to indicate which web is on 
@property(nonatomic) BOOL newsFlag;
@property(nonatomic) BOOL travelFlag;
@property(nonatomic) BOOL sportFlag;
@property(nonatomic) BOOL entertainFlag;

@end
