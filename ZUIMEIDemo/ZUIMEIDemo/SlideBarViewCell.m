//
//  SlideBarViewCell.m
//  ZUIMEIDemo
//
//  Created by zhangle on 16/1/12.
//  Copyright © 2016年 zhangle. All rights reserved.
//

#import "SlideBarViewCell.h"

@implementation SlideBarViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *iconView = [[UIImageView alloc]init];
        UIImage *image = [UIImage imageNamed:@"button_white_normal"];
        image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height *0.5, image.size.width *0.5, image.size.height *0.5, image.size.width *0.5) ];
        iconView.image = image;
        iconView.frame = CGRectMake(0, CGRectGetHeight(frame) * 0.5 - 10, CGRectGetWidth(frame), CGRectGetHeight(frame));
        [self.contentView addSubview:iconView];
        _imageView = iconView;
    }
    return self;
}

@end
