//
//  CellView.h
//  Newspaper_3
//
//  Created by Mac on 1/21/18.
//  Copyright © 2018 Mac. All rights reserved.
//
#import <UIKit/UIKit.h>

@protocol CellViewDelegate <NSObject>

@required
-(void)moveToDetailView:(ItemModel *)currentItem;

@end

@interface CellView : UITableViewCell
{
    ItemModel *currentItem;
}

@property (nonatomic, weak) IBOutlet UIImageView *imgView;
@property (nonatomic, weak) IBOutlet UILabel *descrip;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet UIButton *detailButton;

@property(nonatomic,weak) id<CellViewDelegate> delegate;

-(void)setCellWithItem:(ItemModel *)itemModel;

@end
