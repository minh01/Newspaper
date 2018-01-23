//
//  HeaderView.h
//  Newspaper_3
//
//  Created by Mac on 1/21/18.
//  Copyright © 2018 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderView : UIView
{
    UIViewController *parentController;
}
@property(nonatomic,weak) IBOutlet UIButton *backButton;

-(void)setHeaderWithController:(UIViewController *)controller;

@end
