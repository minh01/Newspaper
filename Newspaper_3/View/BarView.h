//
//  BarView.h
//  Newspaper_3
//
//  Created by Mac on 1/22/18.
//  Copyright © 2018 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BarView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

-(void)setTitle:(NSString *)title andImage:(UIImage *)img andTitleColor:(BOOL)flag;

@end
