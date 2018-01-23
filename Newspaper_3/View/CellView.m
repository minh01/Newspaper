//
//  CellView.m
//  Newspaper_3
//
//  Created by Mac on 1/21/18.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "CellView.h"

@implementation CellView

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)setCellWithItem:(ItemModel *)itemModel
{
    currentItem = itemModel;

    UIView *bgColorView = [[UIView alloc]init];
    [bgColorView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:1.0 alpha:0.5]];
    [self setSelectedBackgroundView:bgColorView];

    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[currentItem imgLink]]];
    [self.imgView setImage:[UIImage imageWithData:imageData]];

    self.descrip.numberOfLines = 6;
    [self.descrip setFont:[UIFont fontWithName:@"Palatino" size:14]];
    NSMutableAttributedString *aString = [[NSMutableAttributedString alloc]initWithString:[currentItem descrip]];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    [style setLineSpacing:3.5];
    [style setLineBreakMode:NSLineBreakByTruncatingTail];
    [style setAlignment:NSTextAlignmentJustified];
    [aString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, aString.length)];
    [self.descrip setAttributedText:aString];


    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"E, dd MMM yyyy HH:mm:ss Z"];
    NSDate *pubDate = [formatter dateFromString:[currentItem pubdate]];
    NSString *dateString;
    if(pubDate != nil) {
        [formatter setDateFormat:@"dd/MM/yyyy  HH:mm:ss"];
        dateString = [formatter stringFromDate:pubDate];
    }
    [self.dateLabel setText:dateString];
    [self.dateLabel setFont:[UIFont fontWithName:@"Palatino" size:14]];
    [self.dateLabel sizeToFit];
}

-(IBAction)goToDetail:(id)sender
{
    if(self.delegate!=nil && [self.delegate respondsToSelector:@selector(moveToDetailView:)])
    {
        [self.delegate moveToDetailView:currentItem];
    }
}

@end
