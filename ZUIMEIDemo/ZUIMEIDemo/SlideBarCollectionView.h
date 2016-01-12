//
//  SlideBarCollectionView.h
//  ZUIMEIDemo
//
//  Created by zhangle on 16/1/12.
//  Copyright © 2016年 zhangle. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SlideBarCollectionViewDelegate <NSObject>

@optional
- (void)scrollPageAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface SlideBarCollectionView : UICollectionView

@property (strong, nonatomic) NSArray *iconArray;

@property (weak, nonatomic) id<SlideBarCollectionViewDelegate>slideDelegate;

- (void)selectBarAtIndexPath:(NSIndexPath *)indexPath;

@end
