//
//  BarView.m
//  Newspaper_3
//
//  Created by Mac on 1/22/18.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "BarView.h"

@implementation BarView

-(instancetype)init
{
    self = [[[NSBundle mainBundle]loadNibNamed:@"BarView" owner:nil options:nil]objectAtIndex:0];

    return self;
}

-(void)setTitle:(NSString *)title andImage:(UIImage *)img andTitleColor:(BOOL)flag
{
    [self setFrame:CGRectMake(0, 0, 35, 35)];
    [self setBackgroundColor: [UIColor clearColor]];

    [self.titleLabel setText:title];
    [self.titleLabel setFont:[UIFont fontWithName:@"Arial" size:10.0]];
    [self.titleLabel sizeToFit];
    [self.titleLabel setFrame:CGRectMake((self.bounds.size.width - self.titleLabel.bounds.size.width)/2, self.bounds.size.height - self.titleLabel.bounds.size.height, self.titleLabel.bounds.size.width, self.titleLabel.bounds.size.height)];
    [self.titleLabel setTextColor: flag?[UIColor blueColor]:[UIColor blackColor]];

    [self.imgView setFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - self.titleLabel.bounds.size.height - 0.6)];
    UIImage *renderedImg = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.imgView setImage:renderedImg];
    [self.imgView setTintColor: flag?[UIColor blueColor]:[UIColor blackColor]];
    [self.imgView setAlpha:0.5];
}

@end
