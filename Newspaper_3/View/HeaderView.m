//
//  HeaderView.m
//  Newspaper_3
//
//  Created by Mac on 1/21/18.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

-(instancetype)init{
    self = [[[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:nil options:nil] objectAtIndex:0];
    return self;
}

-(void)setHeaderWithController:(UIViewController *)controller;
{
    parentController = controller;

    [self setFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVBAR_HEIGHT + STATUS_HEIGHT)];
    [self setBackgroundColor:[UIColor clearColor]];

    CGPoint center = self.center;
    center.x = 20;
    center.y += 10;
    self.backButton.center = center;
}

-(IBAction)goBack:(id)sender
{
    [parentController.navigationController popViewControllerAnimated:YES];
}


@end
