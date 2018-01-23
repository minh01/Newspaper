//
//  DetailViewController.h
//  Newspaper_3
//
//  Created by Mac on 1/21/18.
//  Copyright © 2018 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderView.h"
#import "ItemModel.h"

@interface DetailViewController : UIViewController<UIWebViewDelegate>

@property(nonatomic,strong) ItemModel *itemModel;
@property(nonatomic, weak) IBOutlet UIWebView *myWebView;
@property(nonatomic, weak) IBOutlet UIActivityIndicatorView *loader;

// a flag to indicate which web is on 
@property(nonatomic) BOOL newsFlag;
@property(nonatomic) BOOL travelFlag;
@property(nonatomic) BOOL sportFlag;
@property(nonatomic) BOOL entertainFlag;

@end
